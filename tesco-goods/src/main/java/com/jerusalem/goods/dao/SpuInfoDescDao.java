package com.jerusalem.goods.dao;

import com.jerusalem.goods.entity.SpuInfoDescEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

/****
 * 持久层
 * spu信息介绍
 * @author jerusalem
 * @email 3276586184@qq.com
 * @date 2020-04-09 14:48:19
 */
@Mapper
@Repository
public interface SpuInfoDescDao extends BaseMapper<SpuInfoDescEntity> {
	
}
