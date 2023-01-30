package com.pekall.mdm.user.service.impl;

import com.google.common.base.Joiner;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustAllStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContextBuilder;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.http.*;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Slf4j
public class Vpl706Test {

    public static final String KEY_AUDIO = "audio";
    public static final String FILE_WAV = "/Users/yanglidong/Desktop/test.slk.wav";

    private static final int REST_TIME_OUT = 60000;
    private RestTemplate restTemplate;
    private static final String ADDR = "https://4efb12a3-d9f3-417d-8365-7867e2858a86.mock.pstmn.io";
    private static final String UN = "wuzhijian";
    private static final String GN = "test";
    public static final String TEXT = "地区,方面,保护,显示,作为,政府";

    @Before
    public void setUp() throws Exception {
        ClientHttpRequestFactory clientHttpRequestFactory = clientHttpRequestFactory();
        restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0,
                new StringHttpMessageConverter(Charset.forName("UTF-8")));
        restTemplate.setRequestFactory(clientHttpRequestFactory);
    }

    @Test
    public void registerTest() {
        String url = ADDR + "/runRegFile/" + UN + "/" + GN;
        String result = uploadFile("/Users/yanglidong/Desktop/test.slk.wav", url);
        Assert.assertEquals("/", result);
    }

    @Test
    public void getSnCodeTest() {
        List<HttpMessageConverter<?>> messageConverters = new ArrayList<>();
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Collections.singletonList(MediaType.ALL));
        messageConverters.add(converter);
        restTemplate.setMessageConverters(messageConverters);
        String url = ADDR + "/recog";
        String[] list = restTemplate.getForObject(url, String[].class);
        String result = Joiner.on(",").join(list);
        System.out.println(result);
        Assert.assertEquals(TEXT, result);
    }

    @Test
    public void verifyTest() {
        String text = TEXT;
        String un = UN;
        String fileWav = FILE_WAV;

        String url = ADDR + "/sendwav/" + text + "/" + un;
        String result = uploadFile(fileWav, url);
        System.out.println(result);
        Assert.assertTrue(Integer.parseInt(result) >= 3);
    }

    private String uploadFile(String value, String url) {
        log.info("value:{},url:{}", value, url);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        MultiValueMap<String, String> fileMap = new LinkedMultiValueMap<>();

        ContentDisposition contentDisposition = ContentDisposition
                .builder("form-data")
                .name(KEY_AUDIO)
                .filename(new File(value).getName())
                .build();

        fileMap.add(HttpHeaders.CONTENT_DISPOSITION, contentDisposition.toString());
        HttpEntity fileEntity = null;
        try {
            fileEntity = new HttpEntity(Files.readAllBytes(new File(value).toPath()), fileMap);
        } catch (IOException e) {
            log.error("readLocalFile error, file:" + value, e);
            throw new RuntimeException(e);
        }
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add(KEY_AUDIO, fileEntity);
        HttpEntity<MultiValueMap<String, Object>> request = new HttpEntity<>(body, headers);
        ResponseEntity<String> stringResponseEntity = restTemplate.postForEntity(url, request, String.class);
        log.info("result:{}", stringResponseEntity);
        if (HttpStatus.OK.equals(stringResponseEntity.getStatusCode())) {
            return stringResponseEntity.getBody();
        } else {
            log.error("error code:{}", stringResponseEntity.getStatusCode());
            throw new RuntimeException();
        }
    }

    private ClientHttpRequestFactory clientHttpRequestFactory() {
        try {
            HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();

            // ResourceAccessException will be thrown if timeout expires
            factory.setConnectionRequestTimeout(REST_TIME_OUT);
            factory.setConnectTimeout(REST_TIME_OUT);
            factory.setReadTimeout(REST_TIME_OUT);

            // SSL config
            SSLConnectionSocketFactory socketFactory = new SSLConnectionSocketFactory(
                    new SSLContextBuilder().loadTrustMaterial(new TrustAllStrategy()).build(),
                    NoopHostnameVerifier.INSTANCE);
            CloseableHttpClient httpClient = HttpClients.custom()
                    .setSSLHostnameVerifier(new NoopHostnameVerifier())
                    .setSSLSocketFactory(socketFactory)
                    .disableCookieManagement()
                    .useSystemProperties()
                    .build();
            factory.setHttpClient(httpClient);

            return factory;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyStoreException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }
        return null;
    }

}