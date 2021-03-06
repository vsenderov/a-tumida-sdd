#' Open a DwC CSV File to MaxEnt File
#' 
#' @param dwc The DwC file.
#' @param maxent The Maxent file.
#' @param species Default is "aetina_tumida".
#' 
#' @return Only side-effects.
#' 
#' @example 
#' 
#' dwc2maxent(
#' dwc = "occurrence-data//A-tumida-occurrences-Italy.csv",
#' maxent = "maxent-input//A-tumida-occurrences-Italy.maxent"
#' )
#' 
dwc2maxent <- function(dwc, maxent, species = "aetina_tumida", decimal = FALSE)
{
  data <- read.csv2(file = dwc, encoding = "UTF-8", stringsAsFactors = FALSE)
  if(!decimal) {
    data$decimalLatitude = as.numeric(sapply(data$verbatimLatitude, deg2dec))
    data$decimalLongitude = as.numeric(sapply(data$verbatimLongitude, deg2dec))    
  } else {
    data$decimalLatitude = as.numeric(data$verbatimLatitude)
    data$decimalLongitude =  as.numeric(data$verbatimLongitude)
  }
  
  data$scientificName = rep(x = species, times = nrow(data))
  data <- pk2df(data)
  
  maxent_data = data.frame(
    species = data$scientificName,
    "dd_long" = data$decimalLongitude,
    "dd_lat" = data$decimalLatitude
  )
  
  write.csv(file = maxent, x = maxent_data, quote = FALSE, row.names = FALSE)
  
}



#' Convert Degrees Minutes Seconds to Decimal
#'
#' @param coordinate_vector 
#'
#' @return
#' @export
#'
#' @examples
#' deg2dec(c('38° 30´ 47,76ʺ'))
deg2dec = function(coordinate_vector)
{
  conv_unit(
    gsub("  ", " ", 
      gsub(",", ".",
           gsub(
             pattern = "[\032\"]", replacement = "", stri_enc_toascii(coordinate_vector)
           )
      )
    ),
    from = 'deg_min_sec', to = 'dec_deg'
  )
}




#' Pavel Kolev Data Frame (Wide format with Counts) to DwC (Long Format)
#'
#' @param data PK DF
#' @param life_stage_names the row names, e.g.  c("egg", "larva", "pupa", "adult")
#'
#' @return
#' @export
#'
#' @examples
#' data <- read.csv2(file = "../data/dataset1.csv", encoding = "UTF-8")
#' pk2df(data)

pk2df = function(data, life_stage_names = c("egg", "larva", "pupa", "adult"))
{
  rowToLong = function(data_frame_row)
  {
    right_side <- right_hand_side(arow = data[data_frame_row, life_stage_names])
    left_side <- do.call(
      what = rbind, 
      replicate(
        n = nrow(right_side),
        expr = data[data_frame_row, ],
        simplify = FALSE
      )
    )
    cbind(left_side, right_side)
  }
  
  do.call(
    what = rbind,
    args = lapply(
      1:nrow(data), 
      FUN = rowToLong
      )
  )
}


  
#' Additional Columns to a Pavel Kolev Data Frame
#'
#' @param scientificName e.g. "Aetina tumida"
#' @param arow a row in the PK DF, that has for example counts of "egg", "adult", etc
#'
#' @return
#' @export
#'
#' @examples
#' right_hand_side(arow = data.frame(egg =2, pupa  = 5))
#' 
right_hand_side <- function(scientificName = "Aetina tumida", arow)
{
  lsframe = function(life_stage)
  {
    do.call(
      what = rbind,
      args = replicate(
        n = if(is.na(arow[[life_stage]])) {
          0
        }
        else {
          arow[[life_stage]]
        },
        expr = data.frame(scientificName = scientificName, lifeStage = life_stage, stringsAsFactors = FALSE),
        simplify = FALSE
      )
    )
  }
  do.call(
    what = rbind,
    args = lapply(
      X = names(arow),
      FUN = lsframe 
    )
  )
}
