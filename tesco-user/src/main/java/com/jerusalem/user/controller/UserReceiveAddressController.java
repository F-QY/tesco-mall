package com.jerusalem.user.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.jerusalem.user.entity.UserReceiveAddressEntity;
import com.jerusalem.user.service.UserReceiveAddressService;
import com.jerusalem.common.utils.PageUtils;
import com.jerusalem.common.utils.R;


/****
 * 控制层
 * 用户收货地址
 * @author jerusalem
 * @email 3276586184@qq.com
 * @date 2020-04-20 20:16:14
 */
@RestController
@RequestMapping("user/receive/address")
public class UserReceiveAddressController {

    @Autowired
    private UserReceiveAddressService userReceiveAddressService;

    /***
     * 根据用户id获取收货地址列表
     * @param userId
     * @return
     */
    @GetMapping("/{userId}/address")
    public List<UserReceiveAddressEntity> getAddress(@PathVariable("userId") Long userId){
        List<UserReceiveAddressEntity> list = userReceiveAddressService.getAddressList(userId);
        return list;
    }

    /***
     * 根据id获取收货地址信息
     * @return
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        UserReceiveAddressEntity userReceiveAddress = userReceiveAddressService.getById(id);
        return R.ok().put("userReceiveAddress", userReceiveAddress);
    }



    /***
    * 分页查询
    * @param params
    * @return
    */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = userReceiveAddressService.queryPage(params);

        return R.ok().put("page", page);
    }

    /***
    * 新增
    * @return
    */
    @RequestMapping("/save")
    public R save(@RequestBody UserReceiveAddressEntity userReceiveAddress){
		userReceiveAddressService.save(userReceiveAddress);

        return R.ok();
    }

    /***
    * 修改
    * @return
    */
    @RequestMapping("/update")
    public R update(@RequestBody UserReceiveAddressEntity userReceiveAddress){
		userReceiveAddressService.updateById(userReceiveAddress);

        return R.ok();
    }

    /***
    * 删除
    * @return
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] ids){
		userReceiveAddressService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }
}
