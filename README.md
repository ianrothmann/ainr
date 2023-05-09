# ainr - AI Ninja R Utilities

It is currently able to push Lavaan and Mirt models to AI Ninja for post hoc score estimation.

Install the package by calling `install_github("ianrothmann/ainr")`.

You need to `install.packages("dotenv")` and create a `.env` file in your project.

The env file should look like this:
```
AIN_URL=https://api.aininja.dev
AIN_KEY=[Your key here]
```

In your project, import dotenv and load your env file as follows:

```R
library(dotenv)
load_dot_env(file = "~/Dev/r/ainr/.env")
```

For Lavaan models:
```R
library(lavaan)
library(ainr)

#Normally estimate your model through lavaan
fit <- sem(model, data=myData, estimator = "WLSMV", ordered = c(...))

#Upload your model to AI Ninja
ain.uploadLavaanModel('model_name',model.cons.fit) #replace model_name with a name and version of your model you would like to deploy.
```

It would be a good idea to test score estimation on your model using `lavPredict` before uploading.

For Mirt models:
```R
library(mirt)
library(ainr)

#Normally estimate your model through mirt
cmod <- mirt(myData, itemtype="Rasch", SE=TRUE, verbose=FALSE)

#Upload your model to AI Ninja
ain.uploadMirtModel('model_name',cmod) #replace model_name with a name and version of your model you would like to deploy.
```

It would be a good idea to test score estimation on your model using `fscores` before uploading.
