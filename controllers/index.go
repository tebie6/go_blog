package controllers

import (
	"github.com/astaxie/beego"
)

type IndexController struct {
	beego.Controller
}

func (this *IndexController) Index()  {

	beego.Debug("this is index func")

	this.Layout = "layout.tpl"
	this.TplName = "index.tpl"

}

func (this *IndexController) List() {

	beego.Debug("this is list func")
	return
}