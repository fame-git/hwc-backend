# Backend Test

## Manual for backend

constraints
- No credits, or money for CI/CD tools, nor hosting cloud compute engine
- Huawei cloud didn't support state lock

requirements
- Do one apply at a time to avoid state lock
- set communication channels to notice the guy who control main branch for apply
- based on my experience fetch -> rebase origin/main to fetch resources
- keep up in date, done something, ping or notice colleagues to update a resource to avoid statelock

step:
1. init bucket first
2. implement backend following huawei document
