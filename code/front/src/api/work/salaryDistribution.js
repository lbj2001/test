import request from '@/utils/request'

// 查询薪酬发放分页列表
export function pageListSalaryDistribution(query) {
  return request({
    url: '/work/salaryDistribution/page',
    method: 'get',
    params: query
  })
}

// 查询薪酬发放列表
export function listSalaryDistribution(query) {
  return request({
    url: '/work/salaryDistribution/list',
    method: 'get',
    params: query
  })
}

// 查询薪酬发放详细
export function getSalaryDistribution(id) {
  return request({
    url: '/work/salaryDistribution/' + id,
    method: 'get'
  })
}

// 新增薪酬发放
export function addSalaryDistribution(data) {
  return request({
    url: '/work/salaryDistribution',
    method: 'post',
    data: data
  })
}

// 修改薪酬发放
export function updateSalaryDistribution(data) {
  return request({
    url: '/work/salaryDistribution',
    method: 'put',
    data: data
  })
}

// 删除薪酬发放
export function delSalaryDistribution(id) {
  return request({
    url: '/work/salaryDistribution/' + id,
    method: 'delete'
  })
}

// 薪酬发放
export function updateSalaryStatus(id) {
  return request({
    url: '/work/salaryDistribution/' + id,
    method: 'put'
  })
}
