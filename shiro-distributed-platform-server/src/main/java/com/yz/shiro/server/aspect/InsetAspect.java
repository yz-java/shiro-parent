package com.yz.shiro.server.aspect;

import java.util.Date;

import com.yz.shiro.api.entity.BaseEntity;
import com.yz.shiro.server.utils.UUID;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Before;

/**
 * 
* @ClassName: InsetAspect 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author yangyw(imalex@163.com)
* @date 2015年3月20日 下午1:53:41 
*
 */
//@Aspect
public class InsetAspect {
	Logger logger = Logger.getLogger(InsetAspect.class);

	@Before("execution(* com..service..*.insert*(..))")
	public void add(JoinPoint jp) throws Exception {
		Object[] objects = jp.getArgs();
		if (objects[0] instanceof BaseEntity) {
			Date date = new Date();
			((BaseEntity) objects[0]).setFdid(UUID.getUUID());
			((BaseEntity) objects[0]).setCreatetime(date);
//			((BaseEntity) objects[0]).setCreatorid(UserUtil.getUserId());
			((BaseEntity) objects[0]).setUpdatetime(date);
//			((BaseEntity) objects[0]).setUpdatorid(UserUtil.getUserId());
		}
		logger.info("添加...");
	}

	@Before("execution(* com..service..*.update*(..))")
	public void update(JoinPoint jp) throws Exception {
		Object[] objects = jp.getArgs();
		if (objects[0] instanceof BaseEntity) {
			Date date = new Date();
			((BaseEntity) objects[0]).setUpdatetime(date);
//			((BaseEntity) objects[0]).setUpdatorid(UserUtil.getUserId());
		}
		logger.info("更新...update");
	}
}
