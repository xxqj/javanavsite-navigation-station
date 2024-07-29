package com.fastcms.navsite.controller.api;


import com.fastcms.common.annotation.AnonymousUrls;
import com.fastcms.common.constants.FastcmsConstants;
import com.fastcms.common.model.RestResult;
import com.fastcms.common.model.RestResultUtils;
import com.fastcms.common.qrcode.QRCodeUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.SimpleDateFormat;

@RestController
@RequestMapping(FastcmsConstants.ANONYMOUS_API_PREFIX_MAPPING + "/qr")
public class QrcodeController {

    private static final ThreadLocal<SimpleDateFormat> LOCALDATEFORMAT=ThreadLocal.withInitial(() -> new SimpleDateFormat("yyyyMMddHHmmss"));

    @AnonymousUrls
    @GetMapping
    public void genQrcode(String text, HttpServletRequest request, HttpServletResponse response){


        try {
            QRCodeUtil.createCodeToOutputStream(text,260,260,response.getOutputStream());
            response.setStatus(HttpServletResponse.SC_OK);
            response.flushBuffer();
        }catch (Exception e){
            RestResultUtils.failed(200,null,e.getMessage());
        }
        //return RestResultUtils.success();
    }

}
