import { expect } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Pagination from '@/dictionary/components/Pagination.vue'

describe('Pagination.vue', () => {
  it('renders the Next button if current page is less than totalPages', () => {
    const wrapper = shallowMount(Pagination, {
      props: { currentPage: 1, totalPages: 10 }
    })
    expect(wrapper.find('#next-page-button').exists()).to.eq(true)
  })
})
