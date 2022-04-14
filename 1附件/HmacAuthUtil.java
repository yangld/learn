package com.pekall.mdm.test;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class HmacAuthUtil {

    /**
     * @param appId     用户名
     * @param appSecret 用户共享秘钥
     * @param nonce     随机数
     * @param timestamp 时间戳
     * @return 签名值base64字符串
     */
    public static String sign(String appId, String appSecret, String nonce, String timestamp) {
        SecretKey key = new SecretKeySpec(appSecret.getBytes(StandardCharsets.UTF_8), "HMAC");
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(key);
            String text = appId + nonce + timestamp;
            return Base64.getEncoder().encodeToString(mac.doFinal(text.getBytes(StandardCharsets.UTF_8)));
        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            throw new IllegalStateException(e);
        }
    }
}
