import { mount } from '@vue/test-utils'
import Pagination from '@/dictionary/components/Pagination.vue'

const previousBtnSelector = '[data-test-id="previous-page-btn"]'
const nextBtnSelector = '[data-test-id="next-page-btn"]'

describe('Pagination.vue', () => {
  it('enables the Next button if current page is less than totalPages', () => {
    const wrapper = mount(Pagination, {
      props: { currentPage: 1, totalPages: 10}
    })

    expect(wrapper.find(nextBtnSelector).attributes()['disabled']).toBe(undefined)
  })

  it('disables the Next button if the current page is equal to totalPages', () => {
    const wrapper = mount(Pagination, {
      props: { currentPage: 10, totalPages: 10}
    })

    expect(wrapper.find(nextBtnSelector).attributes()['disabled']).toBe("")
  })

  it('enables the previous button if the current page is greater than 1', () => {
    const wrapper = mount(Pagination, {
      props: { currentPage: 2, totalPages: 10}
    })

    expect(wrapper.find(previousBtnSelector).attributes()['disabled']).toBe(undefined)
  })

  it('disables the Previous button if the current page is equal to 1', () => {
    const wrapper = mount(Pagination, {
      props: { currentPage: 1, totalPages: 10}
    })

    expect(wrapper.find(previousBtnSelector).attributes()['disabled']).toBe("")
  })

  it('displays the correct pagination', () => {
    const wrapper = mount(Pagination, {
      props: { currentPage: 1, totalPages: 10}
    })

    expect(wrapper.html()).toContain('1 of 10')
  })
})