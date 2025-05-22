using CSV, Glob, DataFrames
using Statistics

function performance_testdata( path_to_test, x)
    files = glob( "*_test.csv", path_to_test );
    dfs = DataFrame.( CSV.File.( files ) ); 
    n = length(dfs);

    stocks_return = []
    for i = 1:n
        # compute the realized return R_i(t)
        push!(stocks_return, (dfs[i].Close-dfs[i].Open) ./ dfs[i].Open)
    end
    # calculate r_i and Sigma
    bar_R = [ mean( stocks_return[i] ) for i in 1:n ];
    Sigma = [ mean( (stocks_return[i].-bar_R[i]).*(stocks_return[j].-bar_R[j]) ) for i=1:n, j=1:n ]; 

    # calculate Sharpe Ratio
    portfolio = x;
    if sum( portfolio ) < 1e-10
        sharpe_ratio = 0;
    else
        sharpe_ratio = sum( bar_R.* portfolio ) / sqrt(portfolio'*Sigma*portfolio);
    end

    # extreme event drawdown as risk
    T = length(stocks_return[1])
    return_risk_ratio = -minimum( [ sum(stocks_return[i]*x[i]) for i=1:n ] ) / T

    cost = sum( (x/sum(x)) .>= (0.01/n) ); 
    print("(Test) Sharpe Ratio = ", sharpe_ratio, ", Return = ", sum(bar_R.*portfolio), "\n R-R ratio = ", sum( bar_R.* portfolio ) / return_risk_ratio, " Variance = ", portfolio'*Sigma*portfolio, ", Selected stocks = ", cost, "\n" );
    return sharpe_ratio
end

function performance_traindata( path_to_test, x)
    files = glob( "*_train.csv", path_to_test );
    dfs = DataFrame.( CSV.File.( files ) ); 
    n = length(dfs); 

    stocks_return = []
    for i = 1:n
        # compute the realized return R_i(t)
        push!(stocks_return, (dfs[i].Close-dfs[i].Open) ./ dfs[i].Open)
    end
    # calculate r_i and Sigma
    bar_R = [ mean( stocks_return[i] ) for i in 1:n ];
    Sigma = [ mean( (stocks_return[i].-bar_R[i]).*(stocks_return[j].-bar_R[j]) ) for i=1:n, j=1:n ]; 

    # calculate Sharpe Ratio
    portfolio = x;
    if sum( portfolio ) < 1e-10
        sharpe_ratio = 0;
    else
        sharpe_ratio = sum( bar_R.* portfolio ) / sqrt(portfolio'*Sigma*portfolio);
    end

    # extreme event drawdown as risk
    T = length(stocks_return[1])
    return_risk_ratio = -minimum( [ sum(stocks_return[i]*x[i]) for i=1:n ] ) / T

    cost = sum( (x/sum(x)) .>= (0.01/n) ); 
    print("(Train) Sharpe Ratio = ", sharpe_ratio, ", Return = ", sum(bar_R.*portfolio), "\n R-R ratio = ", sum( bar_R.* portfolio ) / return_risk_ratio, " Variance = ", portfolio'*Sigma*portfolio, ", Selected stocks = ", cost, "\n" );
    return sharpe_ratio
end 

function performance_extradata( path_to_test, x)
    files = glob( "*_extra.csv", path_to_test );
    dfs = DataFrame.( CSV.File.( files ) ); 
    n = length(dfs); 

    stocks_return = []
    for i = 1:n
        # compute the realized return R_i(t)
        push!(stocks_return, (dfs[i].Close-dfs[i].Open) ./ dfs[i].Open)
    end
    # calculate r_i and Sigma
    bar_R = [ mean( stocks_return[i] ) for i in 1:n ];
    Sigma = [ mean( (stocks_return[i].-bar_R[i]).*(stocks_return[j].-bar_R[j]) ) for i=1:n, j=1:n ]; 

    # calculate Sharpe Ratio
    portfolio = x;
    if sum( portfolio ) < 1e-10
        sharpe_ratio = 0;
    else
        sharpe_ratio = sum( bar_R.* portfolio ) / sqrt(portfolio'*Sigma*portfolio);
    end

    # extreme event drawdown as risk
    T = length(stocks_return[1])
    return_risk_ratio = -minimum( [ sum(stocks_return[i]*x[i]) for i=1:n ] ) / T

    cost = sum( (x/sum(x)) .>= (0.01/n) ); 
    print("(Extra) Sharpe Ratio = ", sharpe_ratio, ", Return = ", sum(bar_R.*portfolio), "\n R-R ratio = ", sum( bar_R.* portfolio ) / return_risk_ratio, " Variance = ", portfolio'*Sigma*portfolio, ", Selected stocks = ", cost, "\n" );
    return sharpe_ratio
end 