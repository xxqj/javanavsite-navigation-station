package com.fastcms.common.annotation;


import java.lang.annotation.*;



//https://blog.csdn.net/sinat_15872851/article/details/128285502
@Inherited
@Documented
@Target({ElementType.METHOD,ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface AnonymousUrls {
}
