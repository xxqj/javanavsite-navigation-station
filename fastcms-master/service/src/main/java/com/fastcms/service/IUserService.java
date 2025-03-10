package com.fastcms.service;

import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import com.baomidou.mybatisplus.extension.service.IService;
import com.fastcms.common.exception.FastcmsException;
import com.fastcms.entity.User;
import com.fastcms.entity.UserOpenid;
import com.fastcms.entity.UserTag;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.List;

/**
 * 用户服务类
 * @author wjun_java@163.com
 * @since 2021-02-14
 */
public interface IUserService extends IService<User> {

    /**
     * 根据登录账号获取用户信息
     * @param username
     * @return
     */
    User getByUsername(String username);

    /**
     * 修改用户密码
     * @param updatePasswordParam
     */
    void updateUserPassword(UpdatePasswordParam updatePasswordParam) throws FastcmsException;

    /**
     * 获取用户openid
     * @param userId
     * @param type
     * @return
     */
    String getUserOpenId(Long userId, String type);

    /**
     * 获取用户标签集合
     * @param userId
     * @return
     */
    List<UserTag> getUserTagList(Long userId);

    /**
     * 保存用户信息
     * @param user
     * @return
     */
    Long saveUser(User user) throws FastcmsException;

    /**
     * 保存微信小程序授权用户信息
     * @param userInfo
     * @return
     * @throws FastcmsException
     */
    User saveWxMaUserInfo(String openid, WxMaUserInfo userInfo) throws FastcmsException;

    /**
     * 保存OAuth2授权用户信息
     * @param openid
     * @param nickname
     * @param headimgurl
     * @param sex
     * @param unionid
     * @param sourceType
     * @param type
     * @return
     * @throws FastcmsException
     */
    User saveOAuth2UserInfo(String openid, String nickname, String headimgurl, Integer sex, String unionid, User.SourceType sourceType, String type) throws FastcmsException;

    /**
     * 用户通过手机号授权登录后保存用户信息
     * @param openid
     * @param unionId
     * @param phone
     * @param type
     * @return
     * @throws FastcmsException
     */
    User saveUser(String openid, String unionId, String phone, String type) throws FastcmsException;

    /**
     * 删除用户
     * @param userId
     * @return
     */
    Boolean deleteUser(Long userId) throws FastcmsException;

    /**
     * 用户注册
     * @param username
     * @param nickName
     * @param password
     * @param repeatPassword
     * @return
     */
    Boolean register(String username, String nickName, String password, String repeatPassword) throws FastcmsException;

    /**
     * 获取用户最大id值
     * 用来给小程序或者app授权用户自动生成账号
     * @return
     */
    String getLastUserNum();

    /**
     * 设置用户类型
     * @param userId
     * @param userType
     */
    void changeUserType(Long userId, Integer userType) throws FastcmsException;

    /**
     * 重置用户密码
     * @param userId
     * @throws FastcmsException
     */
    void resetPassword(Long userId) throws FastcmsException;

    /**
     * 重置用户密码
     * @param userName
     * @throws FastcmsException
     */
    void resetPassword(String userName, String email) throws FastcmsException;

    /**
     * 重置用户密码
     * @param user
     * @throws FastcmsException
     */
    void resetPassword(User user) throws FastcmsException;

    /**
     * 根据openid获取用户信息
     * @param openId
     * @return
     */
    User getUserByOpenId(String openId);

    /**
     * 获取第三方OAuth2授权用户openid
     * @param user
     * @return
     */
    UserOpenid getUserOpenid(User user);

    /**
     * 修改用户信息
     */
    class UpdateUserParam implements Serializable {
        /**
         * 昵称
         */
        String nickName;

        /**
         * 用户姓名
         */
        String realName;
        /**
         * 邮箱
         */
        String email;
        /**
         * 手机号
         */
        String mobile;
        /**
         * 性别
         */
        Integer sex;
        /**
         * 个性签名
         */
        String autograph;

        public String getNickName() {
            return nickName;
        }

        public void setNickName(String nickName) {
            this.nickName = nickName;
        }

        public String getRealName() {
            return realName;
        }

        public void setRealName(String realName) {
            this.realName = realName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public Integer getSex() {
            return sex;
        }

        public void setSex(Integer sex) {
            this.sex = sex;
        }

        public String getAutograph() {
            return autograph;
        }

        public void setAutograph(String autograph) {
            this.autograph = autograph;
        }
    }

    /**
     * 修改用户密码
     */
    class UpdatePasswordParam implements Serializable {
        /**
         * 用户id
         */
        Long id;
        /**
         * 旧密码
         */
        @NotBlank(message = "{fastcms.user.oldpassword.notnull}")
        String oldPassword;
        /**
         * 新密码
         */
        @NotBlank(message = "{fastcms.user.password.notnull}")
        String password;
        /**
         * 旧密码
         */
        @NotBlank(message = "{fastcms.user.comfirm.password.not.null}")
        String confirmPassword;
        /**
         * 手机验证码
         */
        String phoneCode;

        public Long getId() {
            return id;
        }

        public void setId(Long id) {
            this.id = id;
        }

        public String getOldPassword() {
            return oldPassword;
        }

        public void setOldPassword(String oldPassword) {
            this.oldPassword = oldPassword;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public String getConfirmPassword() {
            return confirmPassword;
        }

        public void setConfirmPassword(String confirmPassword) {
            this.confirmPassword = confirmPassword;
        }

        public String getPhoneCode() {
            return phoneCode;
        }

        public void setPhoneCode(String phoneCode) {
            this.phoneCode = phoneCode;
        }
    }

    interface UserI18n {
        String USER_OLD_PASSWORD_NOT_NULL = "fastcms.user.oldpassword.notnull";
        String USER_NEW_PASSWORD_NOT_NULL = "fastcms.user.newpassword.notnull";
        String USER_PASSWORD_LENGTH6 = "fastcms.user.password.length6";
        String USER_PASSWORD_ERROR2 = "fastcms.user.password.error2";
        String USER_NOT_EXIST = "fastcms.user.notexist";
        String USER_OLD_PASSWORD_ERROR1 = "fastcms.user.oldpassword.error1";
        String USER_ADMIN_NOT_MODIFY = "fastcms.user.admin.notmodify";
        String USER_ADMIN_NOT_DELETE = "fastcms.user.admin.notdelete";
        String USER_ADMIN_NOT_RESET_PASSWORD = "fastcms.user.admin.not.reset.passowrd";
        String USER_ACCOUNT_NOT_NULL = "fastcms.user.account.notnull";
        String USER_ACCOUNT_REGISTER_ALL_NUMBER = "fastcms.user.account.register.allnumber";
        String USER_ACCOUNT_REGISTER_EXIST = "fastcms.user.register.accountexist";
        String USER_CONFIRM_PASSWORD_NOT_NULL = "fastcms.user.comfirm.password.not.null";
        String USER_DISABLE = "fastcms.user.disable";
        String USER_EMAIL_NOT_NULL = "fastcms.user.email.not.null";
        String USER_EMAIL_NOT_SET = "fastcms.user.email.not.set";
        String USER_EMAIL_ERROR_FOR_REGISTER = "fastcms.user.email.error.for.register";
        String USER_EMAIL_ENABLE_SUBJECT = "fastcms.user.email.enable.subject";
        String USER_EMAIL_ENABLE_CONTENT = "fastcms.user.email.enable.content";
        String USER_TYPE_CHANGE_NOT_MODIFY = "fastcms.user.change.type.not.modify";
        String USER_LOGIN_CAPTCHA_ERROR = "fastcms.user.login.captcha.error";
        String USER_ACCESS_NOT_ALLOW= "fastcms.user.not.access";

        String USER_MINIAPP_PARAMS_ERROR1 = "fastcms.user.miniapp.params.error1";
        String USER_MINIAPP_CODE2SESSION_CODE_IS_NULL = "fastcms.user.miniapp.code2session.code.is.null";
        String USER_MINIAPP_SESSIONKEY_OR_OPENID_IS_NULL = "fastcms.user.miniapp.sessionKey.or.openid.is.null";

        String USER_MINIAPP_LOGIN_FAIL_FOR_EMPTY_SESSION = "fastcms.user.miniapp.login.fail.for.empty.session";
        String USER_MINIAPP_LOGIN_FAIL_FOR_EMPTY_OPENID = "fastcms.user.miniapp.login.fail.for.empty.openid";
        String USER_MINIAPP_LOGIN_FAIL_FOR_USER_INFO_CHECK_ERROR = "fastcms.user.miniapp.login.fail.for.userinfo.check.error";
        String USER_MINIAPP_LOGIN_FAIL_FOR_USER_IS_NULL = "fastcms.user.miniapp.login.fail.for.user.is.null";
        String USER_MINIAPP_LOGIN_FAIL_FOR_GET_PHONE_FAIL = "fastcms.user.miniapp.login.fail.get.phone.fail";
        String USER_MINIAPP_GET_PHONE_FAIL_FOR_EMPTY_SESSION = "fastcms.user.miniapp.get.phone.fail.for.empty.session";

    }

}
