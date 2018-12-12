package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type AuthPermission struct {
	Id int
	Title string
	Pid int
	Level int
	Status int
	Route string
	IsShow int
	IsDel int
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (m *AuthPermission) TableName() string {
	return TableName("auth_permission")
}

// 获取全部数据
func (m *AuthPermission) GetAll() ([] *AuthPermission) {

	o :=  orm.NewOrm()
	list := [] *AuthPermission{}


	// 此处可以做 缓存优化处理
	o.QueryTable( new(AuthPermission).TableName() ).All(&list)

	return list
}