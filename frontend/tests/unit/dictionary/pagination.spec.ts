import { shallowMount } from '@vue/test-utils'
import Pagination from '@/dictionary/components/Pagination.vue'

const previousBtnSelector = '#previous-page-btn'
const nextBtnSelector = '#next-page-btn'

describe('Pagination.vue', () => {
  it('renders the Next button if current page is less than totalPages', () => {
    const wrapper = shallowMount(Pagination, {
      props: { currentPage: 1, totalPages: 10 }
    })

    expect(wrapper.find(nextBtnSelector).exists()).toBe(true)
  })

  it('does not render the Next button if the current page is equal to totalPages', () => {
    const wrapper = shallowMount(Pagination, {
      props: { currentPage: 10, totlPages: 10 }
    })

    expect(wrapper.find(nextBtnSelector).exists()).toBe(false)
  })

  it('renders the previous button if the current page is greater than 1', () => {
    const wrapper = shallowMount(Pagination, {
      props: { currentPage: 2, totalPages: 10 }
    })

    expect(wrapper.find(previousBtnSelector).exists()).toBe(true)
  })

  it('does not render the Previous button if the current page is equal to 1', () => {
    const wrapper = shallowMount(Pagination, {
      props: { currentPage: 1, totalPages: 10 }
    })

    expect(wrapper.find(previousBtnSelector).exists()).toBe(false)
  })
})
