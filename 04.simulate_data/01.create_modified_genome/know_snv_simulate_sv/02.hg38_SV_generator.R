#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
output_prefix <- ifelse(length(args) > 0, args[1], "hg38_SV")

if (!require("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
  library(dplyr)
}

set.seed(12345)

hg38_chrom_sizes <- c(
  chr1 = 248956422, chr2 = 242193529, chr3 = 198295559, chr4 = 190214555,
  chr5 = 181538259, chr6 = 170805979, chr7 = 159345973, chr8 = 145138636,
  chr9 = 138394717, chr10 = 133797422, chr11 = 135086622, chr12 = 133275309,
  chr13 = 114364328, chr14 = 107043718, chr15 = 101991189, chr16 = 90338345,
  chr17 = 83257441, chr18 = 80373285, chr19 = 58617616, chr20 = 64444167,
  chr21 = 46709983, chr22 = 50818468, chrX = 156040895
)

chromosomes <- names(hg38_chrom_sizes)

# 去除两边中间区域
known_repetitive_regions <- list(
  chr1 = list(c(1, 5000000), c(121535434, 124535434), c(248906422, 248956422)),
  chr2 = list(c(1, 5000000), c(92326171, 95326171), c(242143529, 242193529)),
  chr3 = list(c(1, 5000000), c(90500000, 93500000), c(198245559, 198295559)),
  chr4 = list(c(1, 5000000), c(49600000, 52600000), c(190164555, 190214555)),
  chr5 = list(c(1, 5000000), c(46400000, 49400000), c(181488259, 181538259)),
  chr6 = list(c(1, 5000000), c(58000000, 61000000), c(170755979, 170805979)),
  chr7 = list(c(1, 5000000), c(58000000, 61000000), c(159295973, 159345973)),
  chr8 = list(c(1, 5000000), c(43000000, 46000000), c(145088636, 145138636)),
  chr9 = list(c(1, 5000000), c(39947586, 42947586), c(138344717, 138394717)),
  chr10 = list(c(1, 5000000), c(38000000, 41000000), c(133747422, 133797422)),
  chr11 = list(c(1, 5000000), c(51000000, 54000000), c(135036622, 135086622)),
  chr12 = list(c(1, 5000000), c(34800000, 37800000), c(133225309, 133275309)),
  chr13 = list(c(1, 5000000), c(114314328, 114364328)),
  chr14 = list(c(1, 5000000), c(107003718, 107043718)),
  chr15 = list(c(1, 5000000), c(101941189, 101991189)),
  chr16 = list(c(1, 5000000), c(34091514, 37091514), c(90288345, 90338345)),
  chr17 = list(c(1, 5000000), c(22200000, 25200000), c(83212441, 83257441)),
  chr18 = list(c(1, 5000000), c(15400000, 18400000), c(80323285, 80373285)),
  chr19 = list(c(1, 5000000), c(24400000, 27400000), c(58567616, 58617616)),
  chr20 = list(c(1, 5000000), c(26300000, 29300000), c(64394167, 64444167)),
  chr21 = list(c(1, 5000000), c(46659983, 46709983)),
  chr22 = list(c(1, 5000000), c(50768468, 50818468)),
  chrX = list(c(1, 5000000), c(58582012, 61582012), c(155990895, 156040895))
)

# 获取安全的非重复区域
get_safe_regions <- function(chr, chr_size) {
  safe_regions <- list()
  current_start <- 1
  
  # 如果有已知的重复区域
  if (chr %in% names(known_repetitive_regions)) {
    repetitive <- known_repetitive_regions[[chr]]
    
    # 按起始位置排序
    repetitive <- repetitive[order(sapply(repetitive, function(x) x[1]))]
    
    for (region in repetitive) {
      if (current_start < region[1]) {
        # 添加安全区域
        safe_start <- max(current_start, 1)
        safe_end <- region[1] - 1
        if (safe_start <= safe_end) {
          safe_regions <- c(safe_regions, list(c(safe_start, safe_end)))
        }
      }
      current_start <- max(current_start, region[2] + 1)
    }
  }
  
  # 添加最后一段
  if (current_start <= chr_size) {
    safe_regions <- c(safe_regions, list(c(current_start, chr_size)))
  }
  
  # 如果没有任何安全区域，使用中间80%作为后备
  if (length(safe_regions) == 0) {
    safe_start <- round(chr_size * 0.1) + 1
    safe_end <- round(chr_size * 0.9)
    safe_regions <- list(c(safe_start, safe_end))
  }
  
  return(safe_regions)
}

# 从安全区域中随机选择位置
get_random_safe_position <- function(chr, chr_size, min_length = 1) {
  safe_regions <- get_safe_regions(chr, chr_size)
  
  # 计算每个区域的大小并加权随机选择
  region_sizes <- sapply(safe_regions, function(x) x[2] - x[1] + 1)
  total_size <- sum(region_sizes)
  
  if (total_size < min_length) {
    return(NULL)
  }
  
  # 加权随机选择区域
  weights <- region_sizes / total_size
  selected_region_idx <- sample(length(safe_regions), 1, prob = weights)
  selected_region <- safe_regions[[selected_region_idx]]
  
  # 在选定的区域内随机选择位置
  return(sample(selected_region[1]:selected_region[2], 1))
}

# 从安全区域中随机选择一段连续区域
get_random_safe_region <- function(chr, chr_size, region_length) {
  safe_regions <- get_safe_regions(chr, chr_size)
  
  # 只考虑足够大的区域
  valid_regions <- which(sapply(safe_regions, function(x) (x[2] - x[1] + 1) >= region_length))
  
  if (length(valid_regions) == 0) {
    return(NULL)
  }
  
  # 加权随机选择区域
  region_sizes <- sapply(safe_regions[valid_regions], function(x) x[2] - x[1] + 1)
  weights <- region_sizes / sum(region_sizes)
  selected_region_idx <- sample(valid_regions, 1, prob = weights)
  selected_region <- safe_regions[[selected_region_idx]]
  
  # 在选定的区域内随机选择起始位置
  max_start <- selected_region[2] - region_length + 1
  start_pos <- sample(selected_region[1]:max_start, 1)
  
  return(c(start_pos, start_pos + region_length - 1))
}

# 生成随机插入的函数
generate_insertions <- function(n = 1000) {
  cat("生成插入变异...\n")
  insertions <- data.frame(
    chr = character(n),
    start = integer(n),
    end = integer(n),
    type = character(n),
    inserted_seq = character(n),
    length = integer(n),
    stringsAsFactors = FALSE
  )
  
  bases <- c("A", "C", "G", "T")
  
  for (i in 1:n) {
    # 随机选择染色体
    chr <- sample(chromosomes, 1)
    chr_size <- hg38_chrom_sizes[chr]
    
    # 获取安全位置
    pos <- get_random_safe_position(chr, chr_size)
    
    if (!is.null(pos)) {
      # 随机生成插入序列长度 (50-2500 bp)
      seq_length <- sample(50:5000, 1)
      
      # 随机生成插入序列
      inserted_sequence <- paste0(sample(bases, seq_length, replace = TRUE), collapse = "")
      
      insertions[i, ] <- list(
        chr = chr,
        start = pos,
        end = pos,  # 插入是点事件，start和end相同
        type = "insertion",
        inserted_seq = inserted_sequence,
        length = seq_length
      )
    } else {
      # 如果找不到安全位置，使用简单方法
      safe_start <- round(chr_size * 0.1) + 1
      safe_end <- round(chr_size * 0.9)
      pos <- sample(safe_start:safe_end, 1)
      
      seq_length <- sample(50:5000, 1)
      inserted_sequence <- paste0(sample(bases, seq_length, replace = TRUE), collapse = "")
      
      insertions[i, ] <- list(
        chr = chr,
        start = pos,
        end = pos,
        type = "insertion",
        inserted_seq = inserted_sequence,
        length = seq_length
      )
    }
  }
  
  return(insertions)
}

# 生成随机缺失的函数
generate_deletions <- function(n = 1000) {
  cat("生成缺失变异...\n")
  deletions <- data.frame(
    chr = character(n),
    start = integer(n),
    end = integer(n),
    type = character(n),
    deleted_seq = character(n),
    length = integer(n),
    stringsAsFactors = FALSE
  )
  
  for (i in 1:n) {
    success <- FALSE
    attempts <- 0
    
    while (!success && attempts < 100) {
      attempts <- attempts + 1
      
      # 随机选择染色体
      chr <- sample(chromosomes, 1)
      chr_size <- hg38_chrom_sizes[chr]
      
      # 随机生成缺失长度 (50-2500 bp)
      del_length <- sample(50:5000, 1)
      
      # 获取安全区域
      safe_region <- get_random_safe_region(chr, chr_size, del_length)
      
      if (!is.null(safe_region)) {
        start_pos <- safe_region[1]
        end_pos <- safe_region[2]
        
        deletions[i, ] <- list(
          chr = chr,
          start = start_pos,
          end = end_pos,
          type = "deletion",
          deleted_seq = "None",
          length = del_length
        )
        success <- TRUE
      }
    }
    
    if (!success) {
      # 如果无法找到安全区域，使用简单方法
      chr <- sample(chromosomes, 1)
      chr_size <- hg38_chrom_sizes[chr]
      del_length <- sample(50:5000, 1)
      
      safe_start <- round(chr_size * 0.1) + 1
      safe_end <- round(chr_size * 0.9)
      max_start <- safe_end - del_length + 1
      
      if (max_start >= safe_start) {
        start_pos <- sample(safe_start:max_start, 1)
        end_pos <- start_pos + del_length - 1
        
        deletions[i, ] <- list(
          chr = chr,
          start = start_pos,
          end = end_pos,
          type = "deletion",
          deleted_seq = "None",
          length = del_length
        )
      } else {
        # 如果仍然无法找到，使用整个染色体
        start_pos <- sample(1:(chr_size - del_length), 1)
        end_pos <- start_pos + del_length - 1
        
        deletions[i, ] <- list(
          chr = chr,
          start = start_pos,
          end = end_pos,
          type = "deletion",
          deleted_seq = "None",
          length = del_length
        )
      }
    }
  }
  
  return(deletions)
}

# 格式化输出函数
format_insertion_output <- function(insertion_df) {
  output <- character(nrow(insertion_df))
  for (i in 1:nrow(insertion_df)) {
    output[i] <- sprintf("%s\t%d\t%d\t%s\t%s\t%d",
                         insertion_df$chr[i],
                         insertion_df$start[i],
                         insertion_df$end[i],
                         insertion_df$type[i],
                         insertion_df$inserted_seq[i],
                         insertion_df$length[i])
  }
  return(output)
}

format_deletion_output <- function(deletion_df) {
  output <- character(nrow(deletion_df))
  for (i in 1:nrow(deletion_df)) {
    output[i] <- sprintf("%s\t%d\t%d\t%s\t%s\t%d",
                         deletion_df$chr[i],
                         deletion_df$start[i],
                         deletion_df$end[i],
                         deletion_df$type[i],
                         deletion_df$deleted_seq[i],
                         deletion_df$length[i])
  }
  return(output)
}

# 主函数
main <- function() {
  cat("=== hg38结构变异生成器 ===\n")
  cat("输出前缀:", output_prefix, "\n")
  
  # 生成1000个插入和1000个缺失
  insertions <- generate_insertions(1000)
  deletions <- generate_deletions(1000)
  
  # 生成格式化输出
  insertion_output <- format_insertion_output(insertions)
  deletion_output <- format_deletion_output(deletions)
  
  # 保存到文件
  insertion_file <- paste0(output_prefix, "_insertions_1000.txt")
  deletion_file <- paste0(output_prefix, "_deletions_1000.txt")
  
  writeLines(insertion_output, insertion_file)
  writeLines(deletion_output, deletion_file)
  
  # 显示统计信息
  cat("=== 统计信息 ===\n")
  cat(sprintf("生成的插入数量: %d\n", nrow(insertions)))
  cat(sprintf("生成的缺失数量: %d\n", nrow(deletions)))
  cat(sprintf("插入长度范围: %d - %d bp\n", min(insertions$length), max(insertions$length)))
  cat(sprintf("缺失长度范围: %d - %d bp\n", min(deletions$length), max(deletions$length)))
  
  # 染色体分布统计
  cat(sprintf("\n=== 染色体分布 ===\n"))
  cat("插入的染色体分布:\n")
  print(table(insertions$chr))
  
  cat("\n缺失的染色体分布:\n")
  print(table(deletions$chr))
  
  # 显示前几个示例
  #cat("\n=== 前3个插入示例 ===\n")
  #head(insertion_output, 3) |> writeLines()
  
 # cat("\n=== 前3个缺失示例 ===\n")
  #head(deletion_output, 3) |> writeLines()
  
  # 验证变异是否在安全区域内
  check_variants_in_safe_regions <- function(variants_df, variant_type) {
    in_safe_region <- 0
    
    for (i in 1:nrow(variants_df)) {
      chr <- variants_df$chr[i]
      pos <- ifelse(variant_type == "插入", variants_df$start[i], variants_df$start[i])
      chr_size <- hg38_chrom_sizes[chr]
      
      # 获取安全区域
      safe_regions <- get_safe_regions(chr, chr_size)
      
      # 检查是否在任何安全区域内
      in_any_safe_region <- any(sapply(safe_regions, function(region) {
        pos >= region[1] && pos <= region[2]
      }))
      
      if (in_any_safe_region) {
        in_safe_region <- in_safe_region + 1
      }
    }
    
    cat(sprintf("\n=== %s位置验证 ===\n", variant_type))
    cat(sprintf("总%s数: %d\n", variant_type, nrow(variants_df)))
    cat(sprintf("在安全区域内的%s数: %d (%.1f%%)\n", 
                variant_type, in_safe_region, in_safe_region/nrow(variants_df)*100))
    cat(sprintf("在潜在重复区域内的%s数: %d (%.1f%%)\n", 
                variant_type, nrow(variants_df) - in_safe_region, 
                (nrow(variants_df) - in_safe_region)/nrow(variants_df)*100))
  }
  
  check_variants_in_safe_regions(insertions, "插入")
  check_variants_in_safe_regions(deletions, "缺失")
  
  cat("\n=== 文件已保存 ===\n")
  cat("插入文件:", insertion_file, "\n")
  cat("缺失文件:", deletion_file, "\n")
  cat("完成!\n")
}

# 运行主函数
main()
