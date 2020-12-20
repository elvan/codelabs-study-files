import { DragDropModule } from '@angular/cdk/drag-drop';
import { NgModule } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbarModule } from '@angular/material/toolbar';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppComponent } from './app.component';
import { TaskComponent } from './task/task.component';

@NgModule({
  declarations: [AppComponent, TaskComponent],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MatToolbarModule,
    MatIconModule,
    MatCardModule,
    DragDropModule,
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
