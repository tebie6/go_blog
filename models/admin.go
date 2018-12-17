package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type Admin struct {
	Id 		int64
	Username  string
	Password  string
	Status	int64
	RoleId 	int64
	Phone   int64
	Email	string
	CreatedAt time.Time
	UpdatedAt time.Time
}

func (m *Admin) TableName() string {
	return TableName("admin")
}

// 查询所有
func (m *Admin) GetListByWhere(filter *Filter) ([] *Admin, int64){

	o :=  orm.NewOrm()
	list := [] *Admin{}

	if filter.Page < 1{
		filter.Page = 1
	}

	// 接受页码
	if filter.Page < 1 {
		filter.Page = 1
	}

	// 计算偏移量
	offset := (filter.Page - 1) * filter.PageSize

	query := o.QueryTable( new(Admin).TableName())

	count, _ := query.Count()

	if count > 0 {

		query.OrderBy("-created_at").Limit(filter.PageSize, offset).All(&list)
	}


	return list, count
}