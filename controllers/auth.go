package controllers

import (
	"go_demo/models"
	"strings"
	"time"
)

type AuthController struct {
	baseController
}

var (
	AuthRoleModel *models.AuthRole
)

// 角色编辑页面
func (this *AuthController) Role(){

	id, _ := this.GetInt("id")

	if id != 0 {
		role := models.AuthRole{Id:id}
		this.o.Read(&role)
		this.Data["role"] = role
	}

	this.TplName = this.controllerName + "/roleform.html"
}

// 角色保存
func (this *AuthController) RoleSave(){

	id, _ := this.GetInt("id")

	role := models.AuthRole{}
	role.RoleName = this.GetString("role_name")
	role.RoleAliasName = this.GetString("role_alias_name")
	role.Descr = this.GetString("descr")
	role.UpdatedAt = time.Now()

	if id == 0 {

		role.CreatedAt = time.Now()
		if _, err := this.o.Insert(&role); err != nil {

			this.renderJson(500, "角色保存失败"+err.Error(), nil)
		} else {

			this.renderJson(200, "角色保存成功", map[string] string{"url":"/auth/roleList"})
		}

	} else {

		role.Id = id
		_, err := this.o.Update(&role,"RoleName", "RoleAliasName", "Descr", "UpdatedAt");
		if err != nil {

			this.renderJson(500, "角色保存失败"+err.Error(), nil)
		} else {

			this.renderJson(200, "角色保存成功", map[string] string{"url":"/auth/roleList"})
		}
	}

	this.ServeJSON()
}

// 角色列表
func (this *AuthController) RoleList(){

	if this.Ctx.Request.Method == "POST" {

		//role := [] *models.AuthRole{}
		//
		//this.o.QueryTable( new(models.AuthRole).TableName() ).All(&role)

		// 接受设置参数
		filter := models.Filter{}
		filter.Page, _ = this.GetInt("page")
		filter.PageSize, _ = this.GetInt("limit")

		// 调用 GetAll 方法
		roleList, count := AuthRoleModel.GetAll(&filter)

		// 设置扩展参数
		this.setInputData(Response{Count:count})

		// 渲染并输出数据
		this.renderJson(0, "success", roleList)
	}

	this.TplName = this.controllerName + "/role_list.html"
}


// 删除角色
func (this *AuthController) RoleDelete(){

	// TODO 此处需要优化
	ids := strings.Join(this.GetStrings("ids[]"), ",")

	res := AuthRoleModel.BatchDelete(ids)
	if res == false {
		this.renderJson(500, "删除失败", nil)

	} else {
		this.renderJson(200, "删除成功", nil)
	}

}