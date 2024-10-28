import { chromium as playwright } from "playwright-core";
import chromium from "@sparticuz/chromium";

export async function scrapingTitle(url: string) {
  const browser = await playwright.launch({
    args: chromium.args,
    executablePath: await chromium.executablePath(),
    headless: true,
  });
  const page = await browser.newPage();
  await page.goto(url);
  const pageTitle = await page.title();
  await browser.close();
  return pageTitle;
}
