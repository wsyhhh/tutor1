handler <- function(...) {
    requestInfo <- list(...) # This list will contain all the request parameters
    # Request info parameters received -  
    # resource,path,httpMethod,headers,multiValueHeaders,queryStringParameters,
    # multiValueQueryStringParameters,pathParameters,stageVariables,requestContext,body,isBase64Encoded]
    
    # print(requestInfo)
    
    # print(requestInfo['httpMethod'])
    if(requestInfo['httpMethod'] == "GET") {
        return (list(
            statusCode = 301,
            headers = list("Location" = "https://minhvuh.github.io/tutor1/"),
            body = ""
        ))
    }
    else if(requestInfo['httpMethod'] == "POST") {
        request = requestInfo["body"]
        print(request)
        print(class(request))
        print(length(request))
        string <- toJSON(list(request))
        print(string)
        print(length(string))
        num_char <- nchar(as.character(string))
        print(num_char)

        if (num_char == 13) {
            ev <- "Please key in your answer"
        } else {
            res <- substr(string,12,num_char-4)
            #res <- gsub("\n", "\\n", res)
            print(res)
            print(class(res))
            salary <- c(21000, 23400, 26800)
            employee <- c('John Doe','Peter Gynn','Jolie Hope')
            employ.data <- data.frame(employee, salary)
            m <- mean(employ.data$salary)
            print(m)
            ex <- expression(res)
            test <- eval(parse(text=res))
            print(test)
            print(class(test))
            if (is.na(m == test)) {
                ev <-"Try again!"
            } else if (m==test) {
                ev <- "Correct!"
            } else {
                ev <- "Try again"
            }
        }
        result <- list(
            statusCode = 200,
            headers = list("Content-Type" = "application/json", 'Access-Control-Allow-Origin' = '*'),
            body = ev
            #[{"body":["{\"code\":\"x <- 6\"}"]}]
            #[{"body":["x <- 5+5\nX <- list(height = 5.4, weight = 54)"]}]
        )
        #print(result)
        return (result)
    }
    else {
        return (list(
            statusCode = 200,
            body = "Hi from the R Lambda Function :)",
            headers = list('Access-Control-Allow-Origin' = '*')
        ))
    }
    
}