inat_ggplot_t <- function(place, titleplace, filename, colx, coly, colfill, xlabel, ylabel, legtitle){
  ggplot2::ggplot(place) +
    #    aes(x = scientific_name, y = observed_on_string) +  # this one works, but I don't like date format
    # aes(x = scientific_name, y = date_time) +
    ggplot2::aes(x = colx, y = coly) +
    ggplot2::geom_tile(size = .1, ggplot2::aes(fill = colfill), colour = "grey50") +
    #  scale_x_discrete(guide = guide_axis(n.dodge=3)) +
    ggplot2::scale_x_discrete(limits = rev) + # reverses order of labels
    ggplot2::labs(subtitle = titleplace, title = "My iNaturalist Research Grade Observations", x = xlabel, y = ylabel) + # coord_flip
    #theme_classic() +
    # theme for 90° angle to position date right at axis tick
    # theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 4), axis.text.y = element_text(size = 4)) +
    # them hjust centres date at axis tick
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(vjust = 1, hjust = .5, size = 8),
      axis.text.y = ggplot2::element_text(size = 5),
      plot.title = ggplot2::element_text(hjust = 0.5, size = 12),
      plot.subtitle = ggplot2::element_text(hjust = 0.5, size = 12),
      legend.position ="bottom",
      legend.text = ggplot2::element_text(size=6)) +
      ggplot2::labs(fill=legtitle) +
    ggplot2::coord_flip()

  aspect_ratio <- 2.5
  ggplot2::ggsave(filename, height = 10 , width = 3 * aspect_ratio)
}

## Read Data
# inat_esqlag <- readRDS("./inst/extdata/esquimalt_lagoon_sub.RDS")
## find column names
# colnames(inat_esqlag)
## find place name
# inat_esqlag$place
## create and save ggplot.jpg
# inat_ggplot_t(inat_esqlag, "Esquimalt Lagoon", "./inst/extdata/inat_ggplot.jpg", inat_esqlag$scientific_name, inat_esqlag$date, inat_esqlag$Genus, "Scientific Name", "Date")
