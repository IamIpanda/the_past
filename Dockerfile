FROM node AS frontend
WORKDIR /home/iami/app/the_past
COPY frontend/package* /home/iami/app/the_past/
RUN npm install
COPY frontend .
RUN npx coffee -c -b src
RUN PUBLIC_URL=/the_past npm run-script build

FROM node:lts-alpine3.12
WORKDIR /home/iami/app/the_past
COPY backend/package* backend/
RUN cd backend && npm install
COPY . .
COPY --from=frontend /home/iami/app/the_past/build backend/static 
ENTRYPOINT [ "npm", "start" ]