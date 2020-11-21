import { mount } from '@vue/test-utils'
import SearchResults from '@/dictionary/components/SearchResults.vue'

const previousBtnSelector = '[data-test-id="previous-page-btn"]'
const nextBtnSelector = '[data-test-id="next-page-btn"]'

const wrapperForPagination = (currentPage: number, totalPages: number) => {
  return mount(SearchResults, {
      props: { isSearching: false, searchDone: true, resultsCount: 100, currentPage: currentPage, totalPages: totalPages }
  })
}

describe('SearchResults.vue', () => {
  it('displays No results when searching is done and results count is 0', () => {
    const wrapper = mount(SearchResults, {
      props: { isSearching: false, searchDone: true, resultsCount: 0 }
    })

    expect(wrapper.html()).toContain('No results')
  })

  it('displays the number of results', () => {
    const wrapper = mount(SearchResults, {
      props: { isSearching: false, searchDone: true, resultsCount: 100 }
    })

    expect(wrapper.html()).toContain('100 results found')
    expect(wrapper.html()).not.toContain('No results')
  })
  it('enables the Next button if current page is less than totalPages', () => {
    expect(wrapperForPagination(1, 10).find(nextBtnSelector).attributes()['disabled']).toBe(undefined)
  })

  it('disables the Next button if the current page is equal to totalPages', () => {
    expect(wrapperForPagination(10, 10).find(nextBtnSelector).attributes()['disabled']).toBe("")
  })

  it('enables the previous button if the current page is greater than 1', () => {
    expect(wrapperForPagination(2, 10).find(previousBtnSelector).attributes()['disabled']).toBe(undefined)
  })

  it('disables the Previous button if the current page is equal to 1', () => {
    expect(wrapperForPagination(1, 10).find(previousBtnSelector).attributes()['disabled']).toBe("")
  })
})
