package routers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
	"go_demo/controllers"
	"go_demo/models"
	"strings"
)

type router struct {
	beego.Controller
}
func init() {

    // 首页
    beego.Router("/", &controllers.IndexController{}, "*:Index")

    // Admin自动匹配  例如  /admin/login
    beego.AutoRouter(&controllers.AdminController{})

    // Admin 登陆验证
    beego.InsertFilter("/admin/*", beego.BeforeRouter, adminLoginFilter)
}


func adminLoginFilter(ctx *context.Context){

	URI := ctx.Request.RequestURI

	if strings.Index(URI, "/admin/login") == 0{
		return
	}

	beego.Emergency("this is emergency")
	beego.Alert("this is alert")
	beego.Critical("this is critical")
	beego.Error("this is error")
	beego.Warning("this is warning")
	beego.Notice("this is notice")
	beego.Informational("this is informational")
	beego.Debug("this is debug")

	if _, ok := ctx.Input.Session("user").(models.User); ok == false {
		//ctx.Redirect(302, "/admin/login")
	}

}
