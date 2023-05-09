library(httr)
library(dotenv)


ain.uploadLavaanModel <- function(name,fitObj){
 obj <- ain.internal.prepareLavaanObject(name,fitObj)
 fileName <- ain.internal.saveRDS(name,obj)
 ain.internal.uploadModel(name,fileName)
}

ain.uploadMirtModel <- function(name,fitObj){
  obj <- ain.internal.prepareMirtObject(name,fitObj)
  fileName <- ain.internal.saveRDS(name,obj)
  ain.internal.uploadModel(name,fileName)
}

ain.internal.prepareLavaanObject <- function(name,obj){
  obj
}

ain.internal.prepareMirtObject <- function(name,obj){
  obj
}

ain.internal.saveRDS <- function (name,obj) {
  fileName=tempfile(name,fileext = '.rds')
  saveRDS(obj,fileName)
  fileName
}

ain.internal.uploadModel <- function(modelName, modelPath){
  file <- upload_file(modelPath)
  url <- paste0(Sys.getenv("AIN_URL"),'/api/v1/models/r')
  token <- Sys.getenv("AIN_KEY")
  headers <- add_headers('Authorization' = paste("Bearer",token))
  response <- POST(url, body = list("name"=modelName,"file"=file), headers)
  if(http_error(response$status_code)){
    stop(content(response,"text"))
  }
  TRUE
}
