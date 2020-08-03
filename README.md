# Twieker

## About

Twieker allows users to search for topics on Twitter that people are tweeting about.

## Filter Tweets

Tweets can be filtered by **recents** and **popular**.

**Recent:** All relevant tweets published in the past 7 days.

**Popular:** Tweets most likely posted by verified accounts.

## Design Pattern

The Model-View-ViewModel Design pattern is used to develop the app which is a nice way to seperate presentation from business logic. This allows the view to not be dependant on any model.

## Twitter Standard API

The standard search API is free to use but requires a developer account to generate the necessary API keys.
In this particular app we used the bearer token in the authorization header of the request.

The standard API only focus on relevance. This means that some user's tweets may not be available. Twitter advices to rather user the Premium or Enterprise API's for completeness.
