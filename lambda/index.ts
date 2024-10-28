import { Context, APIGatewayProxyResult, APIGatewayEvent } from "aws-lambda";
import { scrapingTitle } from "./scrapingTitle";

export const handler = async (
  event: APIGatewayEvent,
  context: Context
): Promise<APIGatewayProxyResult> => {
  console.log(`Event: ${JSON.stringify(event, null, 2)}`);
  console.log(`Context: ${JSON.stringify(context, null, 2)}`);
  return {
    statusCode: 200,
    body: JSON.stringify({
      message: await scrapingTitle("https://example.com"),
      // title: Example Domain
    }),
  };
};
