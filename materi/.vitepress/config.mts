import { withSidebar } from 'vitepress-sidebar'

// https://vitepress.dev/reference/site-config
export default withSidebar({
  title: "Materialized View",
  description: "CS117",
  base: "/materialized-view-workshop/",
  ignoreDeadLinks: true
}, { documentRootPath: '/materi' })
