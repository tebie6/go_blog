package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"strings"
)

type baseController struct {
	beego.Controller // 内嵌了 beego.Controller 这就是Go的嵌入方式，也就是 MainController 自动拥有了所有 beego.Controller 的方法。
	o orm.Ormer		 // 创建一个 ORM Ormer
	controllerName string
	actionName	   string
}

// Prepare 这个函数主要是为了用户扩展用的，这个函数会在下面定义的这些Method方法之前执行，用户可以重写这个函数实现类似用户验证之类。
func (this *baseController) Prepare()  {

	// 获取controllerName 和 actionName 并且转小写截取
	controllerName, actionName := this.GetControllerAndAction()
	this.controllerName, this.actionName = strings.ToLower(controllerName[0 : len(controllerName)-10]), strings.ToLower(actionName)

	this.o = orm.NewOrm()

	// 做登陆验证
	if this.controllerName == "admin" && this.actionName != "login" {

		beego.Debug(this.GetSession("user"))
		if this.GetSession("user") == nil {
			//this.Ctx.Redirect(302, "/admin/login")
		}
	}

	//beego.Debug("controllerName : " + this.controllerName + " ----------- actionName :  " + this.actionName)
}

// 返回信息提示
func (p *baseController) History(msg string, url string) {
	if url == ""{
		p.Ctx.WriteString("<script>alert('"+msg+"');window.history.go(-1);</script>")
		p.StopRun()
	}else{
		p.Redirect(url,302)
	}
}

// 获取用户IP地址
func (p *baseController) getClientIp() string {
	s := strings.Split(p.Ctx.Request.RemoteAddr, ":")
	return s[0]
}