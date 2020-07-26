FROM node AS frontend
WORKDIR /home/iami/app/the_past
COPY frontend .
RUN npm install
RUN PUBLIC_URL=/the_past npm run-script build

FROM node:lts-alpine3.12
WORKDIR /home/iami/app/the_past
COPY backend/package* backend/
RUN cd backend && npm install
COPY . .
COPY --from=frontend build backend/static 
ENTRYPOINT [ "npm", "start" ]