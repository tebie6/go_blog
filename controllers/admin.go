package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"go_demo/models"
	"go_demo/util"
	"strconv"
	"strings"
	"time"
)

// 声明一个AdminController控制器
type AdminController struct {
	baseController
}


// 首页
func (this *AdminController) Index(){


	this.TplName = this.controllerName + "/index.html"
}

// 登录
func (this *AdminController) Login(){

	if this.Ctx.Request.Method == "POST" {

		username := this.GetString("username")
		password := this.GetString("password")

		// 查询用户信息并验证
		user := models.User{Username:username}
		this.o.Read(&user,"username")

		if password == "" {
			this.History("账号不存在","")
		}

		if util.Md5(password) != strings.Trim(user.Password, " ") {
			this.History("密码错误", "")
		}

		user.LastIp = this.getClientIp()
		user.LoginCount = user.LoginCount +1

		// 更新登陆信息
		if _, err := this.o.Update(&user); err != nil {
			this.History("登录异常", "")
		} else {
			this.History("登录成功", "/admin/index.html")
		}

		// 记录session信息
		this.SetSession("user", user)

	}

	this.TplName = this.controllerName + "/login.html"
}

// 退出
func (this *AdminController) Logout(){

	// 销毁session
	this.DelSession("user")
	this.Ctx.Redirect(302,"/admin/login")

}

// 文章
func (this *AdminController) Article(){

	categorys := [] *models.Category{}

	this.o.QueryTable( new(models.Category).TableName() ).All(&categorys)

	id,_ := this.GetInt("id")

	if id != 0 {
		post := models.Post{Id:id}
		this.o.Read(&post)
		this.Data["post"] = post

	}

	this.Data["categorys"] = categorys

	this.TplName = this.controllerName + "/article.html"
}

// 文章列表
func (this *AdminController) ArticleList(){

	categorys := [] *models.Category{}

	this.o.QueryTable( new(models.Category).TableName() ).All(&categorys)

	var (
		page 	 int
		pagesize int = 8
		offset 	 int
		list 	 []*models.Post
		keyword  string
		cateId 	 int
	)

	keyword = this.GetString("keyword")
	cateId, _ = this.GetInt("cate_id")

	// 接受页码
	if page, _ = this.GetInt("page"); page < 1 {
		page = 1;
	}

	// 计算偏移量
	offset = (page - 1) * pagesize

	query := this.o.QueryTable( new(models.Post).TableName())

	// 关键字搜索
	if keyword != "" {
		query = query.Filter("title__contains", keyword)
	}

	count, _ := query.Count()

	if count > 0 {

		query.OrderBy("-is_top", "-created").Limit(pagesize, offset).All(&list)
	}

	this.Data["keyword"]   = keyword
	this.Data["cateId"]    = cateId
	this.Data["list"]	   = list
	this.Data["categorys"] = categorys
	this.Data["pagebar"]   = util.NewPager(page, int(count), pagesize,
		fmt.Sprintf("/admin/articlelist.html?keyword=%s", keyword), true).ToString()

	this.TplName = this.controllerName + "/article_list.html"
}

// 文章保存
func (this *AdminController) Save(){

	id, _ := this.GetInt("id")

	post := models.Post{}
	post.UserId = 1
	post.Title = this.Input().Get("title")
	post.Content = this.Input().Get("content")
	post.IsTop,_ = this.GetInt8("is_top")
	post.Types,_ = this.GetInt8("types")
	post.Tags = this.Input().Get("tags")
	post.Url = this.Input().Get("url")
	post.CategoryId, _ = this.GetInt("cate_id")
	post.Info = this.Input().Get("info")
	post.Image = this.Input().Get("image")
	post.Created = time.Now()
	post.Updated = time.Now()

	if id == 0 {

		if _, err := this.o.Insert(&post); err != nil {

			this.History("插入数据错误"+err.Error(), "")
		} else {

			this.History("插入数据成功", "/admin/articlelist.html")
		}

	} else {

		post.Id = id

		if _, err := this.o.Update(&post); err != nil {

			this.History("更新数据出错"+err.Error(), "")
		} else {

			this.History("插入数据成功", "/admin/articlelist.html")
		}
	}
}

// 文章删除
func (this *AdminController) Delete(){

	id, err := this.GetInt("id")

	if err != nil {
		this.History("参数错误", "")
	}else{
		if _,err := this.o.Delete(&models.Post{Id:id}); err !=nil{
			this.History("未能成功删除", "")
		}else {
			this.History("删除成功", "/admin/articlelist.html")
		}
	}
}

// 分类管理
func (this *AdminController) Category(){

	categorys := [] *models.Category{}

	this.o.QueryTable( new(models.Category).TableName() ).All(&categorys)

	this.Data["categorys"] = categorys

	this.TplName = this.controllerName + "/category.html"
}

// 添加修改分类 【编辑页】
func (this *AdminController) Categoryadd(){

	//id, _ := this.GetInt("id")
	id := this.Input().Get("id")

	if id != "" {

		intId, _ := strconv.Atoi(id)

		category := models.Category{Id: intId}
		this.o.Read(&category)
		this.Data["cate"] = category
	}

	beego.Debug(this.Data["cate"])

	this.TplName = this.controllerName + "/category_add.html"

}

// 添加修改分类 【执行save】
func (this *AdminController) CategorySave(){

	id := this.Input().Get("id")
	name := this.GetString("name")

	category := models.Category{}
	category.Name = name

	if id == "" {

		if _, err := this.o.Insert(&category); err != nil {

			this.History("插入数据错误", "")
		} else {

			this.History("插入数据成功", "/admin/category.html")
		}

	} else {

		intId, err := strconv.Atoi(id)
		if err != nil {
			this.History("参数错误", "")
		}

		category.Id = intId

		if _, err = this.o.Update(&category); err != nil {

			this.History("更新数据出错", "")
		} else {

			this.History("更新数据成功", "/admin/category.html")
		}
	}

}

// 删除分类
func (this *AdminController) CategoryDel(){

	id, err := strconv.Atoi(this.Input().Get("id"))

	if err != nil {
		this.History("参数错误", "")
	} else {

		category := models.Category{Id: id}

		if _, err := this.o.Delete(&category); err != nil {

			this.History("未能成功删除", "")
		} else {

			this.History("删除成功", "/admin/category.html")
		}
	}




}