





#' Data Frame (Wide format with Counts) to DwC (Long Format)
#'
#' @param data PK DF
#' @param life_stage_names the row names, e.g.  c("egg", "larva", "pupa", "adult")
#'
#' @return
#' @export
#'
#' @examples
#' data <- read.csv2(file = "../data/dataset1.csv", encoding = "UTF-8")
#' wide2long(data)

wide2long = function(data, life_stage_names = c("egg", "larva", "pupa", "adult"))
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
right_hand_side <- function(arow)
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
        expr = data.frame(lifeStage = life_stage, stringsAsFactors = FALSE),
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
