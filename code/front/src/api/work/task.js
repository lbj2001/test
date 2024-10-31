import request from '@/utils/request'

// 查询任务分页列表
export function listPageTask(query) {
  return request({
    url: '/work/task/page',
    method: 'get',
    params: query
  })
}

// 查询任务分页列表
export function listDevPageTask(query) {
  return request({
    url: '/work/task/devPage',
    method: 'get',
    params: query
  })
}

// 查询任务列表
export function listTask(query) {
  return request({
    url: '/work/task/list',
    method: 'get',
    params: query
  })
}

// 查询单人任务列表
export function singleListTask(query) {
  return request({
    url: '/work/task/singleList',
    method: 'get',
    params: query
  })
}

// 查询任务详细
export function getTask(id) {
  return request({
    url: '/work/task/' + id,
    method: 'get'
  })
}

// 查询最新任务
export function getLastTask(appName) {
  return request({
    url: '/work/task/getLastTask?appName=' + appName,
    method: 'get'
  })
}

// 新增任务
export function addTask(data) {
  return request({
    url: '/work/task',
    method: 'post',
    data: data
  })
}

// 修改任务
export function updateTask(data) {
  return request({
    url: '/work/task',
    method: 'put',
    data: data
  })
}

// 领薪分配
export function distribute(data) {
  return request({
    url: '/work/task/distribute',
    method: 'put',
    data: data
  })
}

// 删除任务
export function delTask(id) {
  return request({
    url: '/work/task/' + id,
    method: 'delete'
  })
}

// 查询应用名称列表
export function listAppNames(query) {
  return request({
    url: '/work/task/listAppNames',
    method: 'get',
    params: query
  })
}

// 查询员工名称列表
export function listStaffNames(query) {
  return request({
    url: '/work/task/listStaffNames',
    method: 'get',
    params: query
  })
}

// 查询员工名称列表
export function listDistributeNames(query) {
  return request({
    url: '/work/task/listDistributeNames',
    method: 'get',
    params: query
  })
}

// 查询员工名称列表
export function judgeExistTask(query) {
  return request({
    url: '/work/task/judgeExistTask',
    method: 'get',
    params: query
  })
}

// 查询最新任务
export function listProjectNames(staffNo) {
  return request({
    url: '/work/task/listProjectNames?staffNo=' + staffNo,
    method: 'get'
  })
}

// 查询tag标签列表
export function listTags(query) {
  return request({
    url: '/work/task/getAllTags',
    method: 'get',
    params: query
  })
}

// 获取最新任务
export function getLatestTask(query) {
  return request({
    url: '/work/task/getLatestTask',
    method: 'get',
    params: query
  })
}

// 获取分支任务
export function getBranchTask(query) {
  return request({
    url: '/work/task/getBranchTask',
    method: 'get',
    params: query
  })
}

// 更新任务下发状态
export function updateDistributeStatus(data) {
  return request({
    url: '/work/task/updateDistributeStatus',
    method: 'post',
    data: data
  })
}

