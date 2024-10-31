package com.wh.common.exception.user;

/**
 * 黑名单IP异常类
 * 
 * @author wh
 */
public class BlackListException extends UserException
{
    private static final long serialVersionUID = 1L;

    public BlackListException()
    {
        super("login.blocked", null);
    }
}
