import request from '@/utils/request'
// 查询员工信息分页
export function listPageStaff(query) {
  return request({
    url: '/work/staff/page',
    method: 'get',
    params: query
  })
}

// 查询员工信息列表
export function listStaff(query) {
  return request({
    url: '/work/staff/list',
    method: 'get',
    params: query
  })
}

export function singleListStaff(query) {
  return request({
    url: '/work/staff/singleList',
    method: 'get',
    params: query
  })
}

// 查询员工所有子级
export function listStaffChildren(query) {
  return request({
    url: '/work/staff/listChildren',
    method: 'get',
    params: query
  })
}

// 查询员工所有父级
export function listStaffParents(query) {
  return request({
    url: '/work/staff/listParents',
    method: 'get',
    params: query
  })
}

// 查询员工信息详细
export function getStaff(id) {
  return request({
    url: '/work/staff/' + id,
    method: 'get'
  })
}

// 新增员工信息
export function addStaff(data) {
  return request({
    url: '/work/staff',
    method: 'post',
    data: data
  })
}

// 修改员工信息
export function updateStaff(data) {
  return request({
    url: '/work/staff',
    method: 'put',
    data: data
  })
}

// 删除员工信息
export function delStaff(id) {
  return request({
    url: '/work/staff/' + id,
    method: 'delete'
  })
}

// 解除
export function dismiss(data) {
  return request({
    url: '/work/staff/dismiss',
    method: 'post',
    data: data
  })
}

// 判断是否存在关联关系
export function checkExist(query) {
  return request({
    url: '/work/staff/checkExist',
    method: 'get',
    params: query
  })
}

// 查询领薪员工名称列表
export function listSalaryNames(query) {
  return request({
    url: '/work/staff/listSalaryNames',
    method: 'get',
    params: query
  })
}

// 根据父级查询员工信息列表
export function listStaffByParent(query) {
  return request({
    url: '/work/staff/listByParent',
    method: 'get',
    params: query
  })
}

// 修改员工并行开发状态
export function changeParallelFlag(data) {
  return request({
    url: '/work/staff/updateParallelFlag',
    method: 'post',
    data: data
  })
}
