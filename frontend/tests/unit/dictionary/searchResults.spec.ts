import { mount } from '@vue/test-utils'
import SearchResults from '@/components/SearchResults.vue'


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
})
