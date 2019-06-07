
#
# draw a map from a list of countries and a list 
# of values, using a heat scale.  optionally add
# a title to the map.
#
# requires the `maps` package.
# 
draw.map <- function( countries, values, title ){

  library(maps);
  BERT.graphics.device(cell=T);

  # allow nulls in countries; map to values and ensure zeros.

  c2 <- unlist(countries[!is.na(countries)]);
  values <- as.numeric(values);
  values[is.na(values)] <- 0;
  v2 <- unlist(values[!is.na(countries)]);

  # for colors, reduce to a color space of 32 (?) levels. scale values.

  n <- 32;
  scaled.values <- round((1-((v2-min(v2))/(max(v2) - min(v2))))*(n-1))+1;
  heatcolors <- heat.colors(n);

  margins = c(0, 0, 0, 0);
  if( !missing(title)){ margins[3] <- .6; }

  # fill doesn't work properly (or at least as one would expect) 
  # when a country has multiple polygons, so do this in separate passes...

  # 1: space out the map
  par(mai=margins);
  map("world", c2, fill=F, lty=0);

  # 2: fill in countries
  sapply( c2, function(country){ 
    map( "world", country, fill=T, lty=0, add=T, 
      col=heatcolors[scaled.values[[which(c2==country)]]] );
  });

  # 3: draw lines on top
  map("world", c2, fill=F, col="#cccccc", add=T );

  # add title

  if(!missing(title)){ title( main=title, font.main=1 ); }
  
  dev.off();
  T;
}

