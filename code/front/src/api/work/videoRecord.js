import request from '@/utils/request'

// 查询工时视频记录列表
export function listVideoRecord(query) {
  return request({
    url: '/work/videoRecord/list',
    method: 'get',
    params: query
  })
}

// 查询工时视频记录详细
export function getVideoRecord(id) {
  return request({
    url: '/work/videoRecord/' + id,
    method: 'get'
  })
}

// 新增工时视频记录
export function addVideoRecord(data) {
  return request({
    url: '/work/videoRecord',
    method: 'post',
    data: data
  })
}

// 修改工时视频记录
export function updateVideoRecord(data) {
  return request({
    url: '/work/videoRecord',
    method: 'put',
    data: data
  })
}

// 删除工时视频记录
export function delVideoRecord(id) {
  return request({
    url: '/work/videoRecord/' + id,
    method: 'delete'
  })
}

// 校验视频地址
export function checkVideoAddress() {
  return request({
    url: '/work/videoRecord/checkVideoAddress',
    method: 'get'
  })
}


// 同步视频记录
export function syncVideoRecordList() {
  return request({
    url: '/work/videoRecord/syncVideoRecordList',
    method: 'get'
  })
}

