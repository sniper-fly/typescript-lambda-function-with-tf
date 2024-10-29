import { chromium as playwright } from "playwright-core";
import chromium from "@sparticuz/chromium";
import "dotenv/config";

export async function scrapingTitle(url: string) {
  const binPath =
    process.env.NODE_ENV === "production"
      ? "/opt/nodejs/node_modules/@sparticuz/chromium/bin"
      : undefined;

  const browser = await playwright.launch({
    args: chromium.args,
    executablePath: await chromium.executablePath(binPath),
    headless: true,
  });
  const page = await browser.newPage();
  await page.goto(url);
  const pageTitle = await page.title();
  await browser.close();
  return pageTitle;
}
