package com.jerusalem.goods.service.impl;

import com.jerusalem.goods.service.CategoryBrandRelationService;
import com.jerusalem.goods.vo.Category2Vo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerusalem.common.utils.PageUtils;
import com.jerusalem.common.utils.Query;
import com.jerusalem.goods.dao.CategoryDao;
import com.jerusalem.goods.entity.CategoryEntity;
import com.jerusalem.goods.service.CategoryService;
import org.springframework.transaction.annotation.Transactional;

/****
 * 服务层接口实现类
 * 商品三级分类
 * @author jerusalem
 * @email 3276586184@qq.com
 * @date 2020-04-09 14:48:19
 */
@Service("categoryService")
public class CategoryServiceImpl extends ServiceImpl<CategoryDao, CategoryEntity> implements CategoryService {

    @Autowired
    private CategoryBrandRelationService categoryBrandRelationService;


    /***
     * 查询所有分类，并以树形结构组装
     * @return
     */
    @Override
    public List<CategoryEntity> listWithTree() {
        //1.查出所有分类
        List<CategoryEntity> categoryList = baseMapper.selectList(null);
        //2.组装成父子的树形结构

        //2.1 找到所有的一级分类
        List<CategoryEntity> level1Menus = categoryList.stream().filter(categoryEntity ->
                categoryEntity.getParentCid() == 0
        ).map((menu)->{
            menu.setChildren(getChildrens(menu,categoryList));
            return menu;
        }).sorted((menu1,menu2)->{
            return (menu1.getSort()==null?0:menu1.getSort()) - (menu2.getSort()==null?0:menu2.getSort());
        }).collect(Collectors.toList());
        return level1Menus;
    }

    /**
     * 逻辑删除
     * @param asList
     */
    @Override
    public void removeMenuIds(List<Long> asList) {
        //TODO  1、检查当前删除的菜单，是否被别的地方引用
        baseMapper.deleteBatchIds(asList);
    }

    /**
     * 根据第三级分类ID查询完整的三级分类ID路径
     * 路径示例：[2,25,225]
     * @param categoryId
     * @return
     */
    @Override
    public Long[] findCategoryPath(Long categoryId) {
        List<Long> paths = new ArrayList<>();
        List<Long> parentPath = findParentPath(categoryId, paths);
        //逆序转换
        Collections.reverse(parentPath);
        return parentPath.toArray(new Long[parentPath.size()]);
    }

    /**
    * 分页查询
    * @param params
    * @return
    */
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<CategoryEntity> page = this.page(
                new Query<CategoryEntity>().getPage(params),
                new QueryWrapper<CategoryEntity>()
        );
        return new PageUtils(page);
    }

    /***
     * 级联更新
     * 更新分类表及其他关联表的关联数据
     * @return
     */
    @Transactional
    @Override
    public void updateCascade(CategoryEntity category) {
        this.updateById(category);
        categoryBrandRelationService.updateCategory(category.getCategoryId(),category.getName());
    }

    /***
     * 查询所有的一级分类
     * @return
     */
    @Override
    public List<CategoryEntity> getCategoryLevelOne() {
        QueryWrapper<CategoryEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("category_level",1);
        List<CategoryEntity> categoryList = baseMapper.selectList(queryWrapper);
        return categoryList;
    }

    /***
     * //TODO 不太懂
     * 返回三级分类数据
     * @return
     */
    @Override
    public Map<String, List<Category2Vo>> getCategoryJson() {
        //1.查出所有一级分类
        List<CategoryEntity> categoryOneList = getCategoryLevelOne();
        //2.封装数据
        Map<String, List<Category2Vo>> categoryMap = categoryOneList.stream().collect(Collectors.toMap(key -> key.getCategoryId().toString(), value -> {
            //查出该一级分类的所有二级分类
            QueryWrapper<CategoryEntity> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("parent_cid", value.getCategoryId());
            List<CategoryEntity> categoryTwoList = baseMapper.selectList(queryWrapper);

            //继续封装，得到Category2Vo的形式
            List<Category2Vo> category2Vos = null;
            if (categoryTwoList != null) {
                category2Vos = categoryTwoList.stream().map(categoryTwo -> {
                    Category2Vo category2Vo = new Category2Vo(
                            value.getCategoryId().toString(),
                            null,
                            categoryTwo.getCategoryId().toString(),
                            categoryTwo.getName());
                    //再封装三级分类
                    QueryWrapper<CategoryEntity> queryWrapper1 = new QueryWrapper<>();
                    queryWrapper1.eq("parent_cid",categoryTwo.getCategoryId());
                    List<CategoryEntity> categoryThreeList = baseMapper.selectList(queryWrapper1);
                    if(categoryThreeList != null){
                        List<Category2Vo.Category3Vo> category3Vos = categoryThreeList.stream().map(categoryThree -> {
                            Category2Vo.Category3Vo category3Vo = new Category2Vo.Category3Vo(
                                    categoryTwo.getCategoryId().toString(),
                                    categoryThree.getCategoryId().toString(),
                                    categoryThree.getName()
                            );
                            return category3Vo;
                        }).collect(Collectors.toList());
                        category2Vo.setCategory3List(category3Vos);
                    }
                    return category2Vo;
                }).collect(Collectors.toList());
            }
            return category2Vos;
        }));
        return categoryMap;
    }

    /***
     * 递归查找所有分类的子分类
     * @param root
     * @param all
     * @return
     */
    private List<CategoryEntity> getChildrens(CategoryEntity root,List<CategoryEntity> all){
        List<CategoryEntity> children = all.stream().filter(categoryEntity -> {
            return categoryEntity.getParentCid() == root.getCategoryId();
        }).map(categoryEntity -> {
            //1、找到子菜单
            categoryEntity.setChildren(getChildrens(categoryEntity,all));
            return categoryEntity;
        }).sorted((menu1,menu2)->{
            //2、菜单的排序
            return (menu1.getSort()==null?0:menu1.getSort()) - (menu2.getSort()==null?0:menu2.getSort());
        }).collect(Collectors.toList());
        return children;
    }

    /***
     * 递归查找所有分类的父分类
     * 最终得到逆序[225,25,2]
     * @param categoryId
     * @param paths
     * @return
     */
    private List<Long> findParentPath(Long categoryId,List<Long> paths){
        //收集当前节点id
        paths.add(categoryId);
        CategoryEntity byId = this.getById(categoryId);
        if(byId.getParentCid()!=0){
            findParentPath(byId.getParentCid(),paths);
        }
        return paths;
    }
}