# required packages: ggseqlogo

pwm_df <- readr::read_tsv("work/06_logo/lib_y7oDUzWh-01.95seqs.counts",
                          col_names = c("A", "C", "G", "T")) |>
  tibble::rowid_to_column() |>
  tibble::column_to_rownames("rowid")
pwm <- t(as.matrix(pwm_df))

# compute position-wise Shannon's entropy
pwm_en <- apply(pwm, 2, \(col) -sum(col*log2(col), na.rm = T))

# compute the information content of each base at each position
pwm_ic <- log2(4) - pwm + rep(pwm_en,each=4)

# compute the height of each letter as a product of information content and frequency
pwm_ri <- pwm*pwm_ic

full_plot <-
  ggseqlogo::ggseqlogo(pwm_ri, method = "custom") +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))

trimmed_plot <-
  ggseqlogo::ggseqlogo(pwm_ri[,19:77], method = "custom") +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, hjust = 1))

ggplot2::ggsave("results/lib_y7oDUzWh-01/full_se_logo.png", full_plot, width = 15, height = 4)
ggplot2::ggsave("results/lib_y7oDUzWh-01/trimmed_seq_logo.png", trimmed_plot, width = 12, height = 4)
