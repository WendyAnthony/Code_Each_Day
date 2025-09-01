geo_eccc <- read.csv("data/TEST-GOE-Monitor.csv", header = TRUE, sep = ",")

subregion_natsp <- function(file, colx, coly){
  subregion_exsp <- ggplot(geo_eccc,
                           aes(x = Subregion, y = Exotic_species)) +
    geom_violin(fill = "seagreen2") +
    geom_boxplot(width = 0.1, fill = "sandybrown") +
    theme_minimal() + #get rid of grey background and tick marks
    theme(legend.position="none") + #remove legend
    theme(axis.text.x = element_text(angle = 25, vjust = 1, hjust=1, size = 7)) +
    labs(title='Ploting Subregion by Exotic_species',
         subtitle='ECCC',
         caption = "Chart by Wendy Anthony \n 2025-09-04")
  subregion_exsp
  }


subregion_natsp(geo_eccc, geo_eccc$Subregion, geo_eccc$Percentage_ns)

rlang::last_error()


eccc_ggplot <- function(place, titleplace, filename, colx, coly){
  ggplot2::ggplot(place) +
    #    aes(x = scientific_name, y = observed_on_string) +  # this one works, but I don't like date format
    # aes(x = scientific_name, y = date_time) +
    ggplot2::aes(x = colx, y = coly) +
    ggplot2::geom_tile(size = .1) +
    #  scale_x_discrete(guide = guide_axis(n.dodge=3)) +
    ggplot2::scale_x_discrete(limits = rev) + # reverses order of labels
    ggplot2::labs(subtitle = titleplace, title = "My iNaturalist Research Grade Observations", x = "Scientific Name", y = "Date") + # coord_flip
    #theme_classic() +
    # theme for 90° angle to position date right at axis tick
    # theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1, size = 4), axis.text.y = element_text(size = 4)) +
    # them hjust centres date at axis tick
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(vjust = 1, hjust = .5, size = 8),
      axis.text.y = ggplot2::element_text(size = 5),
      plot.title = ggplot2::element_text(hjust = 0.5, size = 12),
      plot.subtitle = ggplot2::element_text(hjust = 0.5, size = 12)) +
    #legend.position ="bottom",
    #legend.text = ggplot2::element_text(size=6)) +
    ggplot2::coord_flip()

  aspect_ratio <- 2.5
  ggplot2::ggsave(filename, height = 10 , width = 3 * aspect_ratio)
}
