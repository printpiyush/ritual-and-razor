import { chromium } from 'playwright-core'

const BASE = 'http://127.0.0.1:4173'
const EDGE = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe'
const browser = await chromium.launch({ executablePath: EDGE, headless: true })
const ctx = await browser.newContext({ viewport: { width: 390, height: 844 }, isMobile: true, hasTouch: true })
const page = await ctx.newPage()

await page.goto(BASE + '/', { waitUntil: 'networkidle' })
await page.evaluate(() => { localStorage.clear(); sessionStorage.clear() })
await page.reload({ waitUntil: 'networkidle' })

const rows = []
for (const path of ['/', '/join', '/status/S-14', '/display', '/reception', '/barber/Kishan', '/admin']) {
  await page.goto(BASE + path, { waitUntil: 'networkidle' })
  await page.waitForTimeout(200)
  if (await page.getByRole('button', { name: 'ગુજરાતી', exact: true }).isVisible()) {
    await page.getByRole('button', { name: 'ગુજરાતી', exact: true }).click()
    await page.waitForTimeout(200)
  }
  if ((await page.locator('body').innerText()).includes('સ્ટાફ એક્સેસ')) {
    await page.locator('input[type=password]').fill('2468')
    await page.getByRole('button', { name: 'ખોલો', exact: true }).click()
    await page.waitForTimeout(250)
  }
  const data = await page.evaluate(() => ({
    overflow: document.documentElement.scrollWidth - window.innerWidth,
    text: document.body.innerText.split('\n').slice(0, 4).join(' / '),
  }))
  rows.push({ path, ...data })
}
console.log(JSON.stringify(rows, null, 2))
await browser.close()
