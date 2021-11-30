
`@Bean`
 `public` `TomcatServletWebServerFactory webServerFactory() {`
 `TomcatServletWebServerFactory factory =` `new` `TomcatServletWebServerFactory();`
 `factory.addConnectorCustomizers(``new` `TomcatConnectorCustomizer() {`
 `@Override`
 `public` `void` `customize(Connector connector) {`
 `connector.setProperty(``"relaxedPathChars"``,` ``"\"<>[\\]^`{|}"```);`
 `connector.setProperty(``"relaxedQueryChars"``,` ``"\"<>[\\]^`{|}"```);`
 `}`
 `});`
 `return` `factory;`
 `}`

    Created at: 2021-01-20T15:09:10+08:00
    Updated at: 2021-01-20T15:09:10+08:00

