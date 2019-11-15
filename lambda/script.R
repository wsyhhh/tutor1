handler <- function(...) {
    requestInfo <- list(...) # This list will contain all the request parameters
    # Request info parameters received -  
    # resource,path,httpMethod,headers,multiValueHeaders,queryStringParameters,
    # multiValueQueryStringParameters,pathParameters,stageVariables,requestContext,body,isBase64Encoded]
    
    # print(requestInfo)
    
    # print(requestInfo['httpMethod'])
    SIR = Sys.getenv("GIT_PAGE")
    if(requestInfo['httpMethod'] == "GET") {
        return (list(
            statusCode = 301,
            headers = list("Location" = SIR),
            body = ""
        ))
    }
    else if(requestInfo['httpMethod'] == "POST") {
        request = requestInfo["body"]
        print("request")
        print(request)
        print(class(request))
        string <- toJSON(request)
        num_char <- nchar(as.character(string))
        print(num_char)
        print(string)
        print(length(string))
        # print("string")
        # print(string)
        code <- request["body"]
        print("code")
        print(code)
        print(class(code))
        print(length(code))
        print(code[2])
        # print(string)
        # print(length(string))
        # print(num_char)

        if (num_char == 11) {
            ev <- "Please key in your answer"
        } else {
            salary <- c(21000, 23400, 26800)
            employee <- c('John Doe','Peter Gynn','Jolie Hope')
            employ.data <- data.frame(employee, salary)
            m <- mean(employ.data$salary)
            print(m)
            # ex <- expression(code)
            test <- eval(parse(text=code))
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
