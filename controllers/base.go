package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"reflect"
	"strings"
)

type baseController struct {
	beego.Controller         // 内嵌了 beego.Controller 这就是Go的嵌入方式，也就是 MainController 自动拥有了所有 beego.Controller 的方法。
	o              orm.Ormer // 创建一个 ORM Ormer
	controllerName string
	actionName     string
}

type Response struct {
	Code 	int 		`json:"code"`
	Message string 		`json:"message"`
	Data 	interface{} `json:"data"`
	Count	int64		`json:"count"`
}

// Prepare 这个函数主要是为了用户扩展用的，这个函数会在下面定义的这些Method方法之前执行，用户可以重写这个函数实现类似用户验证之类。
func (this *baseController) Prepare() {

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
	if url == "" {
		p.Ctx.WriteString("<script>alert('" + msg + "');window.history.go(-1);</script>")
		p.StopRun()
	} else {
		p.Redirect(url, 302)
	}
}

// 获取用户IP地址
func (p *baseController) getClientIp() string {
	s := strings.Split(p.Ctx.Request.RemoteAddr, ":")
	return s[0]
}


// 设置Ctx数据
func (p *baseController) setInputData(data Response)  {

	t := reflect.TypeOf(data)
	v := reflect.ValueOf(data)
	for k := 0; k < t.NumField(); k++ {
		//beego.Debug(t.Field(k).Type)
		p.Ctx.Input.SetData(t.Field(k).Name, v.Field(k).Interface())
	}
}

// 渲染Json
func (p *baseController) renderJson(code int, message string, data interface{}) {

	responseJson := &Response{}
	responseJson.Code 	  = code
	responseJson.Message  = message
	responseJson.Data     = data

	if count := p.Ctx.Input.GetData("Count"); count !=nil  {
		responseJson.Count    = count.(int64)
	}

	p.Data["json"] = responseJson
	p.ServeJSON()
}
