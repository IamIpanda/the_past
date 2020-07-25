FROM node AS frontend
COPY frontend/package* ./
RUN npm install
COPY frontend .
RUN npm run-script build

FROM node:lts-alpine3.12
WORKDIR /home/iami/app/the_past
COPY backend/package* backend/
RUN cd backend && npm install
COPY . .
COPY --from=frontend build ./static 
ENTRYPOINT [ "npm", "start" ]