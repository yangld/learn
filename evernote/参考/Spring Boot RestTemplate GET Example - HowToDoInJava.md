
# Spring Boot RestTemplate GET Example

In this, **Spring Boot RestTemplate GET** request example, learn to use [RestTemplate](https://howtodoinjava.com/spring-boot2/resttemplate/spring-restful-client-resttemplate-example/) to invoke REST GET API verify api response status code and response entity body.

To create the rest apis, use the sourcecode provided in [spring boot 2 rest api example](https://howtodoinjava.com/spring-boot2/rest/rest-api-example/).

## 1\. Maven dependencies

Make sure to have **spring-boot-starter-web** dependency in the project.

pom.xml

`<``dependency``>`
 `<``groupId``>org.springframework.boot</``groupId``>`
 `<``artifactId``>spring-boot-starter-web</``artifactId``>`
 `<``scope``>test</``scope``>`
`</``dependency``>`

## 2\. Spring Boot RestTemplate GET API Examples

In the given example, I will first write the rest API code and then write the unit-test which invokes the rest API and verifies API response.

#### 2.1. HTTP GET Request

A simple API returning the list of employees in a wrapper object `Employees`.

API Code

`@GetMapping``(value =` `"/employees"``,`
 `produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})`
`public` `EmployeeListVO getAllEmployees(`
 `@RequestHeader``(name =` `"X-COM-PERSIST"``, required =` `true``) String headerPersist,`
 `@RequestHeader``(name =` `"X-COM-LOCATION"``, defaultValue =` `"ASIA"``) String headerLocation)`
`{`
 `LOGGER.info(``"Header X-COM-PERSIST :: "` `+ headerPersist);`
 `LOGGER.info(``"Header X-COM-LOCATION :: "` `+ headerLocation);`

 `EmployeeListVO employees = getEmployeeList();`
 `return` `employees;`
`}`

#### 2.2. RestTemplate example to consume the GET API

In the given example, we are using `RestTemplate` to invoke the above API and verify the API, HTTP response code as well as the response body.

`RestTemplate restTemplate =` `new` `RestTemplate();`

`final` `String baseUrl =` `"[http://localhost:](http://localhost/)"` `+ randomServerPort +` `"/employees"``;`
`URI uri =` `new` `URI(baseUrl);`

`ResponseEntity<String> result = restTemplate.getForEntity(uri, String.``class``);`

`//Verify request succeed`
`Assert.assertEquals(``200``, result.getStatusCodeValue());`
`Assert.assertEquals(``true``, result.getBody().contains(``"employeeList"``));`

#### 2.3. RestTemplate example to send request headers

In this example, we are sending two headers. `X-COM-PERSIST` header is mandatory and `X-COM-LOCATION` is optional.

The example invokes GET API with mandatory headers and verifies the API response code as well as the response body.

> **Note:** RestTemplate `getForEntity()` method does not support request headers. Please use `exchange()` method if headers are necessary.

###### The request is executed successfully

`RestTemplate restTemplate =` `new` `RestTemplate();`

`final` `String baseUrl =` `"[http://localhost:](http://localhost/)"``+randomServerPort+``"/employees/"``;`
`URI uri =` `new` `URI(baseUrl);`

`HttpHeaders headers =` `new` `HttpHeaders();`
`headers.set(``"X-COM-PERSIST"``,` `"true"``);` 
`headers.set(``"X-COM-LOCATION"``,` `"USA"``);`

`HttpEntity<Employee> requestEntity =` `new` `HttpEntity<>(``null``, headers);`

`ResponseEntity<String> result = restTemplate.exchange(uri, HttpMethod.GET, requestEntity, String.``class``);`

`//Verify request succeed`
`Assert.assertEquals(``200``, result.getStatusCodeValue());`
`Assert.assertEquals(``true``, result.getBody().contains(``"employeeList"``));`

###### The request is faled with error code

To produce an error scenario, let’s do not add the mandatory header in the request entity.

`RestTemplate restTemplate =` `new` `RestTemplate();`

`final` `String baseUrl =` `"[http://localhost:](http://localhost/)"``+randomServerPort+``"/employees/"``;`
`URI uri =` `new` `URI(baseUrl);`

`HttpHeaders headers =` `new` `HttpHeaders();`
`headers.set(``"X-COM-LOCATION"``,` `"USA"``);`

`HttpEntity<Employee> requestEntity =` `new` `HttpEntity<>(``null``, headers);`

`try`
`{`
 `restTemplate.exchange(uri, HttpMethod.GET, requestEntity, String.``class``);`
 `Assert.fail();`
`}`
`catch``(HttpClientErrorException ex)`
`{`
 `//Verify bad request and missing header`
 `Assert.assertEquals(``400``, ex.getRawStatusCode());`
 `Assert.assertEquals(``true``, ex.getResponseBodyAsString().contains(``"Missing request header"``));`
`}`

Let me know if you have any queries in this **spring boot RestTemplate get API example**.

Happy Learning !!

[Download Sourcecode](https://howtodoinjava.com/wp-content/downloads/springboot-junit-example.zip)

## Was this post helpful?

ADVERTISEMENTS

[Twitter](https://twitter.com/intent/tweet?text=Spring%20Boot%20RestTemplate%20GET%20Example&url=https%3A%2F%2Fhowtodoinjava.com%2Fspring-boot2%2Fresttemplate%2Fresttemplate-get-example%2F&via=howtodoinjava&related=howtodoinjava)[Facebook](https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fhowtodoinjava.com%2Fspring-boot2%2Fresttemplate%2Fresttemplate-get-example%2F)[LinkedIn](https://www.linkedin.com/shareArticle?mini=1&url=https%3A%2F%2Fhowtodoinjava.com%2Fspring-boot2%2Fresttemplate%2Fresttemplate-get-example%2F&title=Spring%20Boot%20RestTemplate%20GET%20Example&source=https%3A%2F%2Fhowtodoinjava.com)[Reddit](https://www.reddit.com/submit?url=https%3A%2F%2Fhowtodoinjava.com%2Fspring-boot2%2Fresttemplate%2Fresttemplate-get-example%2F)[Pocket](https://getpocket.com/save?url=https%3A%2F%2Fhowtodoinjava.com%2Fspring-boot2%2Fresttemplate%2Fresttemplate-get-example%2F&title=Spring%20Boot%20RestTemplate%20GET%20Example)

    Created at: 2021-01-14T18:24:18+08:00
    Updated at: 2021-01-14T18:24:18+08:00

