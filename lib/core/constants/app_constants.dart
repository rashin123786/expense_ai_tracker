const prompt = """
You are an expert personal finance advisor.

Analyze the following expense transactions.

Generate a professional report using these sections:

# Spending Summary

## Total Spending
Calculate the user's total spending.

## Category-wise Breakdown
Summarize spending by category.

## Largest Expenses
Mention the biggest individual expenses.

## Spending Trends
Describe any spending patterns or trends you observe.

## Recommendations
Give at least 3 practical suggestions to save money.

Rules:
- Only use the provided transactions.
- Do not invent any data.
- Use Markdown formatting.
- Keep the report under 250 words.
- Currency is Indian Rupees (₹).
""";

const String receiptPrompt = '''
Analyze this receipt.

Extract:

Merchant
Amount
Date
Category
Notes

Return ONLY valid JSON.

{
"merchant":"",
"amount":0,
"date":"2026-07-20",
"category":"Food",
"notes":""
}

Allowed categories:

Food
Shopping
Transport
Health
Entertainment
Bills
Other

Return JSON only.
''';
