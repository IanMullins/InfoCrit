# InfoCrit

This is a simple function that I ended up using quite often.

InfoCrit() returns a vector containing the AICs or BICs for autoregressive models of a given variable for lags 0:n .


## Simple usage instructions

1.Download a copy of this function onto your machine

2.Pull the function into your R environment with ```source("your\path\InfoCrit")```

3.The function can now be called like any other ```InfoCrit(data_, column, lags, Type)```

### Parameters
* data_

Expects a dataframe containing atleast 1 named variable
* column

String - Name of the column of the dataframe to be used in the AR model.
* lags

int - Number of lags in the highest order model you want to run.
* Type

String - Default  = "AIC" , but also allows "BIC".At some point I may add others. 


### Technical Considerations

Formula used to calculate the AIC:

![equation](https://latex.codecogs.com/gif.latex?AIC%28p%29%20%3D%20ln%5B%5Cfrac%7BSSR%28p%29%7D%7BT%7D%5D%20&plus;%20%28p%20&plus;%201%29%5Cfrac%7Bln%282%29%7D%7BT%7D)

Formula used to calculate the BIC:

![equation](https://latex.codecogs.com/gif.latex?BIC%28p%29%20%3Dln%5B%5Cfrac%7BSSR%28p%29%7D%7BT%7D%5D%20&plus;%20%28p&plus;1%29%5Cfrac%7Bln%28T%29%7D%7BT%7D)

Where 

* ![equation](https://latex.codecogs.com/gif.latex?SSR%28p%29%5Ctextrm%7B%20is%20%7D%5Csum%5E%7BT%7D_%7Bt%3D1%7D%7B%5Chat%7Bu%7D%5E2_t%7D%20%5Ctextrm%7B%20for%20AR%28p%29%20an%20autoregressive%20model%20of%20order%20p%20%7D)

* T is the total number of time periods

This may not agree with other R functions used to calculate Information criterion as they sometimes use different functions.

## Acknowledgments

Wesely Bundell Ph.D. http://www.wesleyblundell.com/ for assigning the homework that made this necessary. 
