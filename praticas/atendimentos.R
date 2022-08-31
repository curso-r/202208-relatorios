# Aula 2 -------------------------
mapa <- geobr::read_municipality()
mapa_mg <- mapa |>
  dplyr::filter(abbrev_state == "MG")

base_dados <- abjData::pnud_min |>
  dplyr::filter(ano == 2010, uf_sigla == "MG") |>
  dplyr::mutate(muni_id = as.numeric(muni_id))

library(ggplot2)
mapa_mg |>
  dplyr::inner_join(
    base_dados,
    c("code_muni" = "muni_id")
  ) |>
  ggplot() +
  geom_sf(
    aes(fill = idhm),
    colour = "black",
    size = 0.001
  ) +
  scale_fill_viridis_b(
    option = "A", begin = .1, end = .9
  ) +
  theme_void() +
  theme(
    legend.position = "bottom"
  ) +
  labs(
    title = "O IDH municipal é mais alto na parte oeste de MG?"
  )



# -------------------------------------------------------------------------


